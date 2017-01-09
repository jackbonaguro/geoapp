import requests

def getposts(lat, lon):
    data = {'location':{'lat':lat,'lon':lon}}
    res = requests.get(url='http://localhost:3333/posts', json=data)
    return res

def getcomments(id):
    res = requests.get(url='http://localhost:3333/posts/'+str(id)
                       +'/comments')
    return res

def newpost(lat, lon, text):
    data = {'location':{'lat':lat,'lon':lon},'text':text}
    res = requests.post(url='http://localhost:3333/newpost', json=data)
    return res

def newcomment(id, text):
    data = {'text':text}
    res = requests.post(url='http://localhost:3333/posts/'+str(id)
                       +'/newcomment', json=data)
    return res
