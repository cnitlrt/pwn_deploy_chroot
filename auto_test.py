import requests
import json
import sys
import time
from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.webdriver.support import expected_conditions as EC
def getId(name,port):
    headers = {
        "Accept": "application/json",
        "Accept-Encoding": "gzip, deflate",
        "Accept-Language": "zh-CN,zh;q=0.9",
        "CSRF-Token": "296bb5764a58b8a26685be43182ad6bda9255a0527706bc905d233a86a6ea992",
        "Content-Length": "100",
        "Content-Type": "application/json",
        "Cookie": "session=834b6b96-08b4-419c-9bec-c765f5305c38.H21ET1YfuMtaljqi6-wXwudxDhw",
        "Proxy-Connection": "keep-alive",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
    }
    url = f"http://{web_ip}:{web_port}/api/v1/challenges"
    data = {"name":name,"category":"PWN","description":f"nc {web_ip} {port}","value":"100","state":"hidden","type":"standard"}
    r = requests.post(url,json=(data),headers=headers)
    x = json.loads(r.text)
    id = x['data']['id']
    return id
def login():
    url = f"http://{web_ip}:{web_port}/admin/challenges"
    driver.get(url)
    driver.find_element(By.XPATH,r'//*[@id="name"]').send_keys("cnitlrt")
    driver.find_element(By.XPATH,r'//*[@id="password"]').send_keys("nihaoNISHI12..")
    driver.find_element(By.XPATH,r'/html/body/main/div[2]/div/div/form/div[3]/div[2]/input').click()
def upload_file(id,file_path):
    # global flags
    url = f"http://{web_ip}:{web_port}/admin/challenges/{id}#files"
    driver.get(url)
    ac = ActionChains(driver=driver)
    x = driver.find_element(By.XPATH,r'//*[@id="challenge-properties"]/a[1]')
    ac.move_to_element(x)
    ac.click()
    ac.perform()
    time.sleep(1)
    driver.find_element(By.XPATH,r'//*[@id="file"]').send_keys(file_path)
    driver.find_element(By.XPATH,r'//*[@id="_submit"]').click()
def upload_flag(id,flag):
    driver.get(f"http://{web_ip}:{web_port}/admin/challenges/{id}#flags")
    ac = ActionChains(driver=driver)
    x = driver.find_element(By.XPATH,r'//*[@id="challenge-properties"]/a[2]')
    ac.move_to_element(x)
    ac.click()
    ac.perform()
    time.sleep(1)
    x = driver.find_element(By.XPATH,r'/html/body/main/div[5]/div/div[1]/div/div[2]/div/div/div/div/div[3]/button')
    ac.move_to_element(x)
    ac.click()
    ac.perform()
    time.sleep(1)
    x = driver.find_element(By.XPATH,r'//*[@id="flag-create-modal"]/div/div/div[2]/div/select')
    s = Select(x)
    s.select_by_index(1)
    time.sleep(1)
    driver.find_element(By.XPATH,r'//*[@id="create-flag-form"]/div[1]/input').send_keys(flag)
    driver.find_element(By.XPATH,r'//*[@id="flag-create-modal"]/div/div/div[2]/form/button').click()
    time.sleep(1)
    driver.find_element(By.XPATH,r'//*[@id="challenge-update-container"]/form/div[8]/button').click()
def getChallenge():
    headers = {
        "Accept": "application/json",
        "Accept-Encoding": "gzip, deflate",
        "Accept-Language": "zh-CN,zh;q=0.9",
        "CSRF-Token": "296bb5764a58b8a26685be43182ad6bda9255a0527706bc905d233a86a6ea992",
        "Content-Length": "100",
        "Content-Type": "application/json",
        "Cookie": "session=834b6b96-08b4-419c-9bec-c765f5305c38.H21ET1YfuMtaljqi6-wXwudxDhw",
        "Proxy-Connection": "keep-alive",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
    }
    url = f"http://{web_ip}:{web_port}/api/v1/challenges"
    r = requests.get(url,headers=headers)
    r = json.loads(r.text)["data"]
    for m in r:
        is_exist_file.append(m['name'])
if __name__ == "__main__":
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    chrome_options.add_argument('start-maximized')
    chrome_options.add_argument("--disable-extensions")
    chrome_options.add_argument('--disable-browser-side-navigation')
    chrome_options.add_argument('enable-automation')
    chrome_options.add_argument('--disable-infobars')
    chrome_options.add_argument('enable-features=NetworkServiceInProcess')
    if len(sys.argv) != 5:
        print("Usage[+]: python exp.py ip port flags_path bin_path")
        exit(1)
    else:
        web_ip = sys.argv[1]
        web_port = sys.argv[2]
        flags_path = sys.argv[3]
        bin_path = sys.argv[4]
    is_exist_file = []
    getChallenge()
    # print(is_exist_file)
    driver = webdriver.Chrome(options=chrome_options)
    login()
    flags = 0
    with open(f"{flags_path}","r") as f:
        for line in f:
            ll = json.loads(line)
            flag = ll['flag']
            port = ll['port']
            filename = ll['filename']
            if filename in is_exist_file:
                continue
            print(f"Put {filename}")
            id = getId(filename,port)
            time.sleep(1)
            upload_file(id,f"{bin_path}/{filename}")
            time.sleep(1)
            upload_flag(id,flag)
            time.sleep(1)

