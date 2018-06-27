#!/usr/bin/python
#-*-coding:utf-8 -*-

import json,urllib2,sys
#钉钉机器人webhook变量
WebHook="https://oapi.dingtalk.com/robot/send?access_token=07f74361fb63e0674d68ab85f43eb564d53fee42fa56250eda2f86520b8208bf"
#获取第一个参数为message
def get_message():
        if len(sys.argv) < 2:
                print "Usage:%s context." % sys.argv[0]
        else:
                context = sys.argv[1]
        return context
#处理消息
def do_message(context):
        message = {
                "msgtype":"text",
                "text":{
                        "content":context
                },
                "at": {
                        "atMobiles": [
                        "132690xxx"
                        ], 
                        "isAtAll": "false"
                }
        }
        return message
#调用发送消息
def send_reques(webhook):
        context = get_message()
        message = do_message(context)
        json_dump = json.dumps(message)
        req_con = urllib2.Request(webhook,json_dump)
        req_con.add_header('Content-Type', 'application/json')
        response = urllib2.urlopen(req_con)

if __name__ == '__main__':
        send_reques(WebHook)