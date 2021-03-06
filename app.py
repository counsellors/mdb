#!/usr/bin/env python

import os
import uuid
import random
import time
from celery import Celery
from flask.ext.mysql import MySQL
from flask import session
from flask import Flask, render_template, json, request,redirect
from werkzeug import generate_password_hash, check_password_hash


app = Flask(__name__)
mysql = MySQL()
pageLimit = 2
app.secret_key = 'why would I tell you my secret key?'

app.config["MYSQL_DATABASE_USER"] = "root"
app.config["MYSQL_DATABASE_PASSWORD"] = "toor"
app.config["MYSQL_DATABASE_DB"] = "sdb"
app.config["MYSQL_DATABASE_HOST"] = "localhost"
app.config['UPLOAD_FOLDER'] = './static/Uploads'
app.config['CELERY_RESULT_BACKEND'] = "amqp"
app.config['CELERY_BROKER_URL'] = "amqp://guest@localhost//"

mysql.init_app(app)
celery = Celery(app.name,broker=app.config['CELERY_BROKER_URL'])
celery.conf.update(app.config)

@app.route("/")
def main():
    return render_template('index.html')

@app.route("/showSignUp")
def showSignUp():
    return render_template("signup.html")

@app.route("/signUp", methods=["POST"])
def signUp():
    _name = request.form["inputName"]
    _email = request.form["inputEmail"]
    _password = request.form["inputPassword"]

    try:
        if _name and _email and _password:
            conn = mysql.connect()
            cursor = conn.cursor()
            _hashed_password = generate_password_hash(_password)
            cursor.callproc('sp_createUser',(_name,_email,_hashed_password))
            data = cursor.fetchall()

            if len(data) is 0:
                conn.commit()
                return json.dumps({'message':'User created successfully !'})
            else:
                return json.dumps({'error':str(data[0])})
        else:
            return json.dumps({"html":"<span>Enter the required fields</span>"})
    except Exception as e:
        return json.dumps({'error':str(e)})
    finally:
        cursor.close()
        conn.close()

@app.route("/showSignIn")
def showSignIn():
    return render_template("signin.html")

@app.route("/validateLogin",methods=["POST"])
def validateLogin():
    try:
        _username = request.form['inputEmail']
        _password = request.form['inputPassword']

        print _username, _password
        conn = mysql.connect()
        cursor = conn.cursor()
        cursor.callproc("sp_validateLogin", (_username,))
        data = cursor.fetchall()
        if len(data) > 0:
            if check_password_hash(str(data[0][3]), _password):
                session['user'] = data[0][0]
                return redirect('/showDashboard')
            else:
                # return json.dumps({'error':str(data[0])})
                return render_template("error.html",error="Wrong Email address!")
        else:
            return render_template("error.html",error="Wrong Email address or password!")
    except Exception, e:
        print e
        raise render_template("error.html",error=str(e))
    finally:
        cursor.close()
        conn.close()

@app.route('/userHome')
def userHome():
    if session.get('user'):
        return render_template('userHome.html')
    else:
        return render_template('error.html',error = 'Unauthorized Access')

@app.route('/logout')
def logout():
    session.pop('user',None)
    return redirect('/')

@app.route('/showAddWish')
def showAddWish():
    return render_template('addWish.html')
    
@app.route('/addWish',methods=['POST'])
def addWish():
    try:
        if session.get('user'):
            _title = request.form['inputTitle']
            _description = request.form['inputDescription']
            _user = session.get('user')
            if request.form.get('filePath') is None:
                _filePath = ''
            else:
                _filePath = request.form.get('filePath')
                 
            if request.form.get('private') is None:
                _private = 0
            else:
                _private = 1
                 
            if request.form.get('done') is None:
                _done = 0
            else:
                _done = 1
 
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_addWish',(_title,_description,_user,_filePath,_private,_done))
            data = cursor.fetchall()
 
            if len(data) is 0:
                conn.commit()
                return redirect('/userHome')
            else:
                return render_template('error.html',error = 'An error occurred!')
 
        else:
            return render_template('error.html',error = 'Unauthorized Access')
    except Exception as e:
        return render_template('error.html',error = str(e))
    finally:
        cursor.close()
        conn.close()

@app.route('/getWish',methods=['POST'])
def getWish():
    try:
        if session.get('user'):
            _user = session.get('user')
            _limit = pageLimit
            _offset = request.form['offset']
            _total_records = 0

            con = mysql.connect()
            cursor = con.cursor()
            print _user,_limit,_offset,_total_records
            cursor.callproc('sp_GetWishByUser',(_user,_limit,_offset,_total_records))
            wishes = cursor.fetchall()
            cursor.close()
            cursor = con.cursor()
            # use varaible _sp_GetWishByUser_3 to store store-procedure(sp_GetWishByUser)'s out parameter
            # @xxx is varaible
            cursor.execute('SELECT @_sp_GetWishByUser_3');
             
            outParam = cursor.fetchall()
            response = []
            wishes_dict = []
             
            for wish in wishes:
                wish_dict = {
                    'Id': wish[0],
                    'Title': wish[1],
                    'Description': wish[2],
                    'Date': wish[4]}
                wishes_dict.append(wish_dict)
                 
            response.append(wishes_dict)
            response.append({'total':outParam[0][0]}) 
             
            return json.dumps(response)
        else:
            return render_template('index.html', error = 'Unauthorized Access')
    except Exception as e:
        print e,"nothissngaaaa"
        return render_template('error.html', error=str(e))

@app.route('/getWishById',methods=['POST'])
def getWishById():
    try:
        if session.get('user'):
 
            _id = request.form['id']
            _user = session.get('user')
 
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetWishById',(_id,_user))
            result = cursor.fetchall()
 
            wish = []
            wish.append({'Id':result[0][0],'Title':result[0][1]
                ,'Description':result[0][2],'FilePath':result[0][3]
                ,'Private':result[0][4],'Done':result[0][5]})
 
            return json.dumps(wish)
        else:
            return render_template('error.html', error = 'Unauthorized Access')
    except Exception as e:
        return render_template('error.html',error = str(e))

@app.route('/updateWish', methods=['POST'])
def updateWish():
    try:
        if session.get('user'):
            _user = session.get('user')
            _title = request.form['title']
            _description = request.form['description']
            _wish_id = request.form['id']
            _filePath = request.form['filePath']
            _isPrivate = request.form['isPrivate']
            _isDone = request.form['isDone']
 
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_updateWish',(_title,_description,_wish_id,_user,_filePath,_isPrivate,_isDone))
            data = cursor.fetchall()
 
            if len(data) is 0:
                conn.commit()
                return json.dumps({'status':'OK'})
            else:
                return json.dumps({'status':'ERROR'})
    except Exception as e:
        return json.dumps({'status':'Unauthorized access'})
    finally:
        cursor.close()
        conn.close()

@app.route('/deleteWish',methods=['POST'])
def deleteWish():
    try:
        if session.get('user'):
            _id = request.form['id']
            _user = session.get('user')
 
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_deleteWish',(_id,_user))
            result = cursor.fetchall()
 
            if len(result) is 0:
                conn.commit()
                return json.dumps({'status':'OK'})
            else:
                return json.dumps({'status':'An Error occured'})
        else:
            return render_template('error.html',error = 'Unauthorized Access')
    except Exception as e:
        return json.dumps({'status':str(e)})
    finally:
        cursor.close()
        conn.close()

@app.route('/upload', methods=['GET', 'POST'])
def upload():
    try:
        if request.method == 'POST':
            file = request.files['file']
            extension = os.path.splitext(file.filename)[1]
            f_name = str(uuid.uuid4()) + extension
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], f_name))
            return json.dumps({'filename':f_name})
        else:
            print "not post in [upload]"
    except Exception, e:
        print  e

@app.route('/showDashboard')
def showDashboard():
    return render_template('dashboard.html')

@app.route('/getAllWishes')
def getAllWishes():
    try:
        if session.get('user'):
             
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetAllWishes')
            result = cursor.fetchall()

            wishes_dict = []
            for wish in result:
                wish_dict = {
                    'Id': wish[0],
                    'Title': wish[1],
                    'Description': wish[2],
                    'FilePath': wish[3],
                    'Like':wish[4]}
                wishes_dict.append(wish_dict)       
            print json.dumps(wishes_dict)
            return json.dumps(wishes_dict)
        else:
            return render_template('error.html', error = 'Unauthorized Access')
    except Exception as e:
        print e
        return render_template('error.html',error = str(e))

@app.route('/addUpdateLike',methods=['POST'])
def addUpdateLike():
    try:
        if session.get('user'):
            _wishId = request.form['wish']
            _like = request.form['like']
            _user = session.get('user')
            
 
            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_AddUpdateLikes',(_wishId,_user,_like))
            data = cursor.fetchall()
 
            if len(data) is 0:
                conn.commit()
                cursor.close()
                conn.close()

                conn = mysql.connect()
                cursor = conn.cursor()
                cursor.callproc('sp_getLikeStatus',(_wishId,_user))
                
                result = cursor.fetchall()      

                return json.dumps({'status':'OK','total':result[0][0],'likeStatus':result[0][1]})
            else:
                return render_template('error.html',error = 'An error occurred!')
 
        else:
            return render_template('error.html',error = 'Unauthorized Access')
    except Exception as e:
        print e
        return render_template('error.html',error = str(e))
    finally:
        cursor.close()
        conn.close()

@celery.task(bind=True)
def long_task(self):
    """Background task that runs a long function with progress reports."""
    verb = ['Starting up', 'Booting', 'Repairing', 'Loading', 'Checking']
    adjective = ['master', 'radiant', 'silent', 'harmonic', 'fast']
    noun = ['solar array', 'particle reshaper', 'cosmic ray', 'orbiter', 'bit']
    message = ''
    total = random.randint(10, 50)
    for i in range(total):
        if not message or random.random() < 0.25:
            message = '{0} {1} {2}...'.format(random.choice(verb),
                                              random.choice(adjective),
                                              random.choice(noun))
        # celery task's function used to update some dynamic data
        self.update_state(state='PROGRESS',
                          meta={'current': i, 'total': total,
                                'status': message})
        time.sleep(1)
    print "[in celery task]"
    return {'current': 100, 'total': 100, 'status': 'Task completed!',
            'result': 42}

@app.route('/longtask', methods=['GET'])
def longtask():
    try:
        task = long_task.apply_async()
        return task.task_id
    except Exception,e:
        print e

@app.route('/test')
def test():
    return render_template('test.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)