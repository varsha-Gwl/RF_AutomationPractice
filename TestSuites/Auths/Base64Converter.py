import base64

def get_base64_string(user,pwd):
    temp = user+":"+pwd
    base64str = base64.b64encode(temp.encode('utf-8')).decode('utf-8')
    return base64str
