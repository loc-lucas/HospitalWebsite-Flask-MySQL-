from FlaskApp import *

@app.route('/medProc', methods=['POST'])
def medProc():
    pID = session['id']        
    if request.form['latest']:
        cursor.callproc('getMedLatest', (pID))
    else:
        cursor.callproc('getMedAll', (pID))

    data = cursor.fetchall()
    session['med'] = data
    return redirect(url_for('rerenderPatient'))

@app.route('/testProc', methods=['POST'])
def testProc():
    pID = session['id']    
    test = request.form['test']

    cursor.callproc('getTestResLatest', (pID))
    cursor.callproc('getAllTest', (pID))
    cursor.callproc('getAllAbnorTest', (pID, test))

    data = cursor.fetchall()
    session['test'] = data
    return redirect(url_for('rerenderPatient'))

@app.route('/docProc', methods=['POST'])
def docProc():
    pID = session['id']  

    if request.form['latest']:
        cursor.callproc('getDocLatest', (pID))
    else: cursor.callproc('getAllDoc', (pID))

    data = cursor.fetchall()
    session['doc'] = data
    return redirect(url_for('rerenderPatient'))

@app.route('/dietProc', methods=['POST'])    
def dietProc():
    pID = session['id']    

    if request.form['latest']:
        cursor.callproc('getDietLatest', (pID))
    else: cursor.callproc('getAllDiet', (pID))

    data = cursor.fetchall()
    session['diet'] = data
    return redirect(url_for('rerenderPatient'))
    
@app.route('/updateInfo', methods=['POST'])
def updateInfo():
    pID = session['id']
    insurID = request.form['insurID']
    lname = request.form['lname']
    minit = request.form['minit']
    fname = request.form['fname']
    bdate = request.form['bdates']    
    addr = request.form['addr']

    cursor.callproc('updateInfo', (pID, insurID, lname, minit, fname, bdate, addr))
    conn.commit()

@app.route('/patient/proc', methods=['GET', 'POST'])
def rerenderPatient():    
    return render_template('patient.html', departList=session['departList'], diet=session['diet'],
    doc=session['doc'], test=session['test'], med=session['med'])