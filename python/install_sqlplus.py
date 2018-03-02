import os


basic = 'instantclient-basic-macos.x64-12.1.0.2.0.zip'
sqlplus = 'instantclient-sqlplus-macos.x64-12.1.0.2.0.zip'
command = 'cp ' + basic + ' ~/Library/Caches/Homebrew'
command1 = 'cp ' + sqlplus + ' ~/Library/Caches/Homebrew'

os.popen(command)
os.system(command1)

os.system('brew tap InstantClientTap/instantclient')
os.system('brew install instantclient-basic')
os.system('brew install instantclient-sqlplus')

os.chdir()