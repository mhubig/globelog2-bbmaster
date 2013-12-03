#!/usr/bin/env python
# vi: set ft=python :

import os
import dotenv

from twisted.application import service
from buildbot.master import BuildMaster

## load the dotenv file
dotenv.read_dotenv()

## bbmaster settings
bbmaster_basedir = os.path.abspath(os.path.dirname(__file__))
bbmaster_logdir = os.path.join(bbmaster_basedir, 'twistd.log')
bbmaster_rotate_length = '10000000'
bbmaster_max_rotated_files = '10'
bbmaster_configfile = 'master.cfg'
bbmaster_umask = None

## create the application
application = service.Application('buildmaster')

## add logging
try:
    from twisted.python.logfile import LogFile
    from twisted.python.log import ILogObserver, FileLogObserver
    logfile = LogFile.fromFullPath(bbmaster_logdir,
                                   rotateLength=bbmaster_rotate_length,
                                   maxRotatedFiles=bbmaster_max_rotated_files)
    application.setComponent(ILogObserver, FileLogObserver(logfile).emit)
except  ImportError:
    pass

## create the master
m = BuildMaster(bbmaster_basedir, bbmaster_configfile, bbmaster_umask)
m.setServiceParent(application)
m.log_rotation.rotateLength = bbmaster_rotate_length
m.log_rotation.maxRotatedFiles = bbmaster_max_rotated_files
