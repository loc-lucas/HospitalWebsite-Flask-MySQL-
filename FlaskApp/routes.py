from FlaskApp import *
from .login import *
from .patientProc import *
from .doctorProc import *
@app.route('/')
@app.route('/login')
def index():    
    session['loggedIn'] = False
    return render_template('index.html') ## put homepage here

@app.route('/admin')
def admin():    
    if not session['loggedIn']:
        return render_template('index.html', msg='Please login first!!')
    elif session['role'] != 'admin':
        session['id'] = ''
        session['loggedIn'] = False
        return render_template('index.html', msg='This Account has no privilege to access this site! Please log in another account')
    session['msg'] = ''
    session['docData'] = (())
    session['patData'] = (())
    session['testData'] = (())
    session['tab']="doc"
    return render_template('admin.html', departList=session['departList'],
    patData=session['patData'], testData=session['testData'], tabidx=session['tab'])

@app.route('/patient')
def patient():
    if not session['loggedIn']:
        return render_template('index.html', msg='Please login first!!')
    elif session['role'] != 'patient':
        session['id'] = ''
        session['loggedIn'] = False
        return render_template('index.html', msg='This Account has no privilege to access this site! Please log in another account')
    return initPatient()

@app.route('/doctor')
def doctor():
    if not session['loggedIn']:
        return render_template('index.html', msg='Please login first!!')
    elif session['role'] != 'doctor':
        session['id'] = ''
        session['loggedIn'] = False
        return render_template('index.html', msg='This Account has no privilege to access this site! Please log in another account')

    getPatOut()
    # testList = session['testList']
    session['patAbDis'] = (())
    session['patDis'] = (())
    session['patOut'] = (())
    session['lessMed'] = (())
    session['tab'] = "updatePat"
    session['tab2'] = "day"
    session['PatientID'] = ""
    session['FTest'] = (())
    session['Test'] = (())
    session['Medicine'] = (())
    session['Diagnosis'] = (())
    session['nurseList'] = (())
    return render_template('doctor.html',nurseList=session['nurseList'], tabidx=session['tab'], tabidx2=session['tab2'], diseaseList=session['diseaseList'], 
    patOut=session['patOut'], film=(()), test=(()), medicine=(()), diagnosis=(()), testList=session['testList'], medList=session['medList'], filmList=session['filmList'])