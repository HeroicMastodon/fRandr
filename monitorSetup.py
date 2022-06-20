import os
import json
import subprocess

# result = os.system("edid-decode /sys/class/drm/card1-DP-1/edid")
configFileName = 'monitors.json'
enabledKey = 'enabled'

def readConfig():
	with open(configFileName, 'r') as config:
		configData = json.load(config)
		return configData

def saveConfig(configData):
	with open(configFileName, 'w') as config:
		json.dump(configData, config)

def getCurrentHash():
	proc = subprocess.Popen('./detectMonitors.sh', stdout=subprocess.PIPE)
	bytes = proc.stdout.read()
	configHash = ''.join(map(chr, bytes))
	
	return configHash.strip("\n")

data = readConfig()
configHash = getCurrentHash()

if configHash not in data:
	data[configHash] = {}

currSetup = data[configHash]
