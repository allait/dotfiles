import os
from StringIO import StringIO

from fabric.api import local, env, run, put
from fabric.context_managers import cd

def transfer_gpg_keys():
    local("gpg --export-secret-keys > ~/tmp/gpg.sec")
    local("gpg --export-secret-subkeys > ~/tmp/gpg.sub")
    put('~/tmp/gpg.sec', 'gpg.sec')
    put('~/tmp/gpg.sub', 'gpg.sub')
    run('gpg --import ~/gpg.s* &> /dev/null || rm ~/gpg.sub ~/gpg.sec*')
    local('rm ~/tmp/gpg.sub ~/tmp/gpg.sec')

def upload_ssh_key():
    with open(os.path.expanduser('~/.ssh/id_rsa.pub')) as fd:
        key = fd.readline().strip()
    run('mkdir -p ~/.ssh && chmod 700 ~/.ssh')
    run("echo '%s' >> ~/.ssh/authorized_keys && chmod 644 ~/.ssh/authorized_keys" % key)

def install_remote_dotfiles():
    put("zshrc.remote", ".zshrc")
    put("vimrc.remote", ".vimrc")
    put("screenrc", ".screenrc")

# Hosts

def vagrant():
    env.user = 'vagrant'
    env.hosts = ['127.0.0.1:2222']
    res = local('vagrant ssh_config | grep IdentityFile', capture=True)
    env.key_filename = res.split()[1]
