from FlaskApp import *
from .adminProc import *

@app.route('/procLog', methods=['GET', 'POST'])
def procLog():    
    initData()
    if 'id' in request.form and 'pwd' in request.form:
        usr_id = int(request.form['id']) 
        usr_pwd = request.form['pwd']    
    else: return redirect('https://www.youtube.com/watch?v=psZ1g9fMfeo')

    for item in session['usrList']:        
        if usr_id == item[0] and  usr_pwd == item[1] and item[2] == 'admin':
            session['loggedIn'] = True
            session['role'] = 'admin'
            return redirect(url_for('admin'))
        elif usr_id == item[0] and  usr_pwd == item[1] and item[2] == 'doctor':
            session['loggedIn'] = True
            session['role'] = 'doctor'            
            session['id'] = usr_id
            return redirect(url_for('doctor'))
        elif usr_id == item[0] and  usr_pwd == item[1] and item[2] == 'patient':
            session['loggedIn'] = True
            session['role'] = 'patient'            
            session['id'] = usr_id
            return redirect(url_for('patient'))                       
    return 'Cant find any'

def initData():
    # fetch user data
    cursor.execute('SELECT * FROM USR;')
    data = cursor.fetchall()
    session['usrList'] = data

    # fetch doctor data
    cursor.execute('SELECT * FROM DOCTOR;')
    data = cursor.fetchall()
    session['docList'] = data
    
    # fetch patient data
    cursor.execute('SELECT * FROM PATIENT;')
    data = cursor.fetchall()
    session['patList'] = data

    # fetch test data
    cursor.execute('SELECT * FROM TESTLIST;')
    data = cursor.fetchall()
    session['testList'] = data

    # fetch film test data
    cursor.execute('SELECT * FROM PATIENT;')
    data = cursor.fetchall()
    session['filmList'] = data

    # fetch department data
    cursor.execute('SELECT * FROM DEPARTMENT;')
    data = cursor.fetchall()
    session['departList'] = data

    cursor.execute('SELECT * FROM OUTPATIENT;')
    data = cursor.fetchall()
    session['outPatList'] = data

    cursor.execute('SELECT * FROM OUTPATIENT;')
    data = cursor.fetchall()
    session['outPatList'] = data

    # print(session['departList'])
