from FlaskApp import *
from .login import *
@app.route('/')
@app.route('/login')
def index():
    initData()
    return render_template('index.html') ## put homepage here

@app.route('/admin')
def admin():
    session['docData'] = (())
    session['patData'] = (())
    session['testData'] = (())
    return render_template('admin.html', departList=session['departList'],
    patData=session['patData'], testData=session['testData'])

@app.route('/patient')
def patient():
    return render_template('patient.html')

@app.route('/doctor')
def doctor():
    return render_template('doctor.html')

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

    print(session['departList'])
    



