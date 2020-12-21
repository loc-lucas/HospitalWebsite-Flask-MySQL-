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
    # fetch doctor data
    cursor.execute('SELECT * FROM DOCTOR;')
    docList = cursor.fetchall()
    session['docList'] = docList
    
    # fetch patient data
    cursor.execute('SELECT * FROM PATIENT;')
    patList = cursor.fetchall()
    session['patList'] = patList

    # fetch test data
    cursor.execute('SELECT * FROM TESTLIST;')
    testList = cursor.fetchall()
    session['testList'] = testList

    # fetch film test data
    cursor.execute('SELECT * FROM PATIENT;')
    filmList = cursor.fetchall()
    session['filmList'] = filmList

    # fetch department data
    cursor.execute('SELECT * FROM DEPARTMENT;')
    departList = cursor.fetchall()
    session['departList'] = departList

    print(session['departList'])
    



