from fabric.api import local

def update_master():
    local('buildbot upgrade-master master')

def start_buildbot():
    local('buildbot start --nodaemon master')

def run():
    update_master()
    start_buildbot()
