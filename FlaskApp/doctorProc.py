from FlaskApp import *


@app.route('/doctor/getPatWithNorAbnorRes', methods=['POST'])
def getPatWithNorAbnorRes():
    test = request.form['test']
    cursor.callproc('getPatWithNorAbnorRes', (session['id'], test))
    data = cursor.fetchall()
    session['norAb'] = data if data else [[]]
    return redirect(url_for('rerenderDoctor'))

@app.route('/doctor/getBPatWithDecUsed', methods=['POST'])
def getBPatWithDecUsed():
    med = request.form['medicine']
    cursor.callproc('getBPatWithDecUsed', (session['id'], med))
    data = cursor.fetchall()
    session['lessMed'] = data if data else [[]]
    return redirect(url_for('rerenderDoctor'))

@app.route('/doctor/getPatOut', methods=['POST'])
def getPatOut():    
    cursor.callproc('getPatOut', (session['id'], ))
    data = cursor.fetchall()
    session['patOut'] = data if data else [[]]    
    
@app.route('/doctor/getpatdate', methods=['POST'])
def getPat():        
    dates = request.form['dates']
    cursor.callproc('getPatDate', (dates, session['id']))
    data = cursor.fetchall()
    session['patList'] = data if data else [[]]
    return redirect(url_for('rerenderDoctor'))

@app.route('/doctor/disProc', methods=['POST'])
def disProc():
    dID = session['id']
    disease = request.form['desease']    

    cursor.callproc('getPatOfDisease', (dID, disease))
    data = cursor.fetchall()
    session['patDis'] = data if data else [[]]
    return redirect(url_for('rerenderDoctor'))

@app.route('/doctor/abdisProc', methods=['POST'])
def disAbProc():
    dID = session['id']
    disease = request.form['disease']    

    cursor.callproc('getPatOfDiseaseAbnormal', (dID, disease))
    data = cursor.fetchall()
    session['patAbDis'] = data if data else [[]]
    return redirect(url_for('rerenderDoctor'))    

@app.route('/doctor/proc', methods=['GET', 'POST'])
def rerenderDoctor():    
    return render_template('doctor.html', departList=session['departList'], patList=session['patList'],
    patAbDis=session['patAbDis'], patDis=session['patDis'], patOut=session['patOut'], medList=session['medList'],
    lessMed=session['lessMed'], testList=session['testList'])

@app.route('doctor/update', methods=['POST'])
def updateActivity():
# add new examination
    dID = session['id']
    dates = request.form['dates']
    shift = request.form['shift']
    pID = request.form['patientID']
    nID = request.form['nID']
    diagRes = request.form['diagRes']

    if not dates or not shift or not pID or not nID: 
        session['message'] = 'please input all examination parameters'
        return redirect(url_for('rerenderDoctor')) 
    cursor.execute('SELECT DepartID FROM DOCTOR WHERE ID = %s', (dID))
    data = cursor.fetchone()    
    shiftID = data + dates + shift
    cursor.callproc('addExam', (pID, nID, dID, shiftID, diagRes))
    conn.commit()    

    cursor.execute('SELECT ID FROM EXAMINATION ORDER BY ID DESC LIMIT 1')
    data = cursor.fetchone()
    examID = int(data) + 1

# add new test
    tname1 = request.form['tname1']
    tname2 = request.form['tname2']
    tname3 = request.form['tname3']

    resTest1 = request.form['resTest1']
    resTest2 = request.form['resTest2']
    resTest3 = request.form['resTest3']

    note1 = request.form['note1']
    note2 = request.form['note2']
    note3 = request.form['note3']

    cursor.execute('SELECT ID FROM Test ORDER BY ID DESC LIMIT 1')
    data = cursor.fetchone()
    testID = int(data)
    test1 = None 
    test2 = None
    test3 = None
    if tname1 and resTest1 and note1:
        testID = testID + 1
        cursor.callproc('addTest', (testID, resTest1, tname1, note1))                 
        conn.commit()
        test1 = testID
    if tname2 and resTest2 and note2:
        testID = testID + 1
        cursor.callproc('addTest', (testID, resTest2, tname2, note2))                    
        conn.commit()
        test2 = testID
    if tname3 and resTest3 and note3:
        testID = testID + 1
        cursor.callproc('addTest', (testID, resTest3, tname3, note3))                    
        conn.commit()
        test3 = testID


# add new film test
    ftname1 = request.form['ftname1']
    ftname2 = request.form['ftname2']
    ftname3 = request.form['ftname3']

    resFTest1 = request.form['resFTest1']
    resFTest2 = request.form['resFTest2']
    resFTest3 = request.form['resFTest3']

    cursor.execute('SELECT ID FROM Ftest ORDER BY ID DESC LIMIT 1')
    data = cursor.fetchone()
    ftestID = int(data)
    ftest1 = None 
    ftest2 = None
    ftest3 = None

    if ftname1 and resFTest1:
        ftestID = ftestID + 1
        cursor.callproc('addFTest', (ftestID, resFTest1, ftname1))                 
        conn.commit()
        ftest1 = ftestID
    if ftname2 and resFTest2:
        ftestID = ftestID + 1
        cursor.callproc('addFTest', (ftestID, resFTest2, ftname2))                    
        conn.commit()
        ftest2 = ftestID
    if ftname3 and resFTest3:
        ftestID = ftestID + 1
        cursor.callproc('addFTest', (ftestID, resFTest3, ftname3))                    
        conn.commit()
        ftest3 = ftestID

# process new take test    
    cursor.callproc('addTakeTest', (examID, test1, ftest1))
    conn.commit()
    cursor.callproc('addTakeTest', (examID, test2, ftest2))
    conn.commit()            
    cursor.callproc('addTakeTest', (examID, test3, ftest3))
    conn.commit()

# add new prescription
    diet = request.form['diet']
    if diet:
        cursor.callproc('addPres', (examID, dID, diet))
        conn.commit()
        cursor.execute('SELECT ID FROM PRESCRIPTION ORDER BY ID DESC LIMIT 1')
        data = cursor.fetchone()
        presID = int(data)

# add new medicine
    mName1 = request.form['mName1']
    mName2 = request.form['mName2']
    mName3 = request.form['mName3']


    amount1 = request.form['amount1']
    amount2 = request.form['amount2']
    amount3 = request.form['amount3']


    usageDes1 = request.form['usageDes1']
    usageDes2 = request.form['usageDes2']
    usageDes3 = request.form['usageDes3']


    if diet:    
        if mName1 and amount1 and usageDes1:
            cursor.callproc('addMed', (dates, amount1, usageDes1, mName1, presID))
            conn.commit()
        if mName2 and amount2 and usageDes2:
            cursor.callproc('addMed', (dates, amount2, usageDes2, mName3, presID))
            conn.commit()
        if mName3 and amount3 and usageDes3:
            cursor.callproc('addMed', (dates, amount3, usageDes3, mName3, presID))
            conn.commit()            

    return redirect(url_for('rerenderDoctor'))
