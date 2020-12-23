from FlaskApp import *

@app.route('/proc', methods=['POST'])
def proc():
    dID = session['id']    
    pID = request.form['pID']
    
    med = request.form['med']
    test = request.form['test']

    state = request.form['state']
    if state == 'Both':        
        if pID:
            cursor.callproc('getDiagRes', (dID, pID))                 
        if test:
            cursor.callproc('getPatWithNorAbnorRes', (test, dID))            
    elif state == 'Boarded':
        cursor.callproc('getUsedMedOfBP', (dID, pID))
        if med:
            cursor.callproc('getBPatWithDecUsed', (dID, med))
        else: cursor.callproc('getPatOut', (dID))


# @app.route('/testProc', methods=['POST'])
    # data = cursor.fetchall()
    # session['test'] = data
    # return redirect(url_for('rerenderDoctor'))

@app.route('/getpat', methods=['POST'])
def getPat():    
    dates = request.form['dates']
    cursor.callproc('getPatDate', (dates, session['id']))
    patList = cursor.fetchall()
    session['patList'] = patList
    return redirect(url_for(rerenderDoctor))

@app.route('/testProc', methods=['POST'])
def testProc():
    dID = session['id']
    pID = request.form['pID']
    ttype = request.form['ttype']

    if ttype == 'Film': cursor.callproc('getFTestOfBPat', (dID, pID))
    else :cursor.callproc('getTestOfBPat', (dID, pID))
    
    data = cursor.fetchall()
    session['test'] = data
    return redirect(url_for('rerenderDoctor'))

@app.route('/disProc', methods=['POST'])
def disProc():
    dID = session['id']
    disease = request.form['desease']
    res = request.form['res']

    if res == 'Abnormal': cursor.callproc('getPatOfDiseaseAbnormal', (dID, disease))
    else: cursor.callproc('getPatOfDisease', (dID, disease))
    
    data = cursor.fetchall()
    session['pat'] = data
    return redirect(url_for('rerenderDoctor'))

@app.route('/doctor/proc', methods=['GET', 'POST'])
def rerenderDoctor():    
    return render_template('doctor.html', departList=session['departList'])