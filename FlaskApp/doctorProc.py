from FlaskApp import *


@app.route('/doctor/getPatWithNorAbnorRes', methods=['POST'])
def getPatWithNorAbnorRes():
    test = request.form['test']
    cursor.callproc('getPatWithNorAbnorRes', (session['id'], test))
    data = cursor.fetchall()
    session['norAb'] = data if data else [[]]
    session['tab'] = 'list'
    session['tabidx2'] = 'recover'
    return redirect(url_for('rerenderDoctor'))

@app.route('/doctor/getBPatWithDecUsed', methods=['POST'])
def getBPatWithDecUsed():
    med = request.form['medicine']
    cursor.callproc('getBPatWithDecUsed', (session['id'], med))
    data = cursor.fetchall()
    session['lessMed'] = data if data else [[]]
    session['tab'] = 'list'
    session['tab2'] = 'less'
    return redirect(url_for('rerenderDoctor'))

@app.route('/doctor/getPatOut', methods=['POST'])
def getPatOut():    
    cursor.callproc('getPatOut', (session['id'], ))
    data = cursor.fetchall()
    session['tab'] = 'list'
    session['tab2'] = 'cured'
    session['patOut'] = data if data else [[]]    
    
@app.route('/doctor/getpatdate', methods=['POST'])
def getPat():    
    # print(session['id'])
    dates = request.form['dates']
    session['dates'] = dates
    cursor.callproc('getPatDate', (dates, session['id']))
    data = cursor.fetchall()
    session['tab'] = 'list'
    session['tab2'] = 'day'
    session['patList'] = data if data else [[]]
    # print(data)
    # print(session['patList']
    return redirect(url_for('rerenderDoctor'))

@app.route('/doctor/disProc', methods=['POST'])
def disProc():
    dID = session['id']
    disease = request.form['desease']    

    cursor.callproc('getPatOfDisease', (dID, disease))
    data = cursor.fetchall()
    session['patDis'] = data if data else [[]]
    session['tab'] = 'list'
    session['tab2'] = 'disease'
    return redirect(url_for('rerenderDoctor'))


@app.route('/doctor/abdisProc', methods=['POST'])
def disAbProc():
    dID = session['id']
    disease = request.form['disease']    

    cursor.callproc('getPatOfDiseaseAbnormal', (dID, disease))
    data = cursor.fetchall()
    session['patAbDis'] = data if data else [[]]
    session['tab'] = 'list'
    session['tab2'] = 'abnormal'
    return redirect(url_for('rerenderDoctor'))    

    
@app.route('/doctor/getPatDetail', methods=['POST'])
def getPatDetail():
    dID = session['id']
    pID = request.form['patID']
    session['PatientID'] = pID

    cursor.callproc('getDiagRes', (dID, pID))
    data = cursor.fetchall()
    session['Diagnosis']  = data

    cursor.callproc('getFTestOfBPat', (dID, pID))
    data = cursor.fetchall()
    session['FTest'] = data

    cursor.callproc('getTestOfBPat', (dID, pID))
    data = cursor.fetchall()
    session['Test'] = data

    cursor.callproc('getTestOfBPat', (dID, pID))
    data = cursor.fetchall()
    session['Medicine'] = data
    session['tab'] = "detail"
    return redirect(url_for('rerenderDoctor'))    



@app.route('/doctor/proc', methods=['GET', 'POST'])
def rerenderDoctor():    
    return render_template('doctor.html', departList=session['departList'], patList=session['patList'],
    patAbDis=session['patAbDis'], patDis=session['patDis'], patOut=session['patOut'], medList=session['medList'],
    lessMed=session['lessMed'], testList=session['testList'], patID=session['PatientID'], film=session['FTest'], test=session['Test'], medicine=session['Medicine'], diagnosis=session['Diagnosis'], tabidx=session['tab'], tabidx2=session['tab2'], dates=session['dates'], filmList=session['filmList'])   

# @app.route('/proc', methods=[['Post']])
# def proc():
#     dID = session['id']    
#     pID = request.form['pID']
    
#     med = request.form['med']
#     test = request.form['test']

#     state = request.form['state']
#     if state == 'Both':        
#         if pID:
#             cursor.callproc('getDiagRes', (dID, pID))                           
#     elif state == 'Boarded':
#         cursor.callproc('getUsedMedOfBP', (dID, pID))