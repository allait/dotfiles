import os
import tempfile
import shutil

from fabric.api import local, env, run, put


def transfer_gpg_keys():
    local("gpg --export-secret-keys > ~/tmp/gpg.sec")
    local("gpg --export-secret-subkeys > ~/tmp/gpg.sub")
    put('~/tmp/gpg.sec', 'gpg.sec')
    put('~/tmp/gpg.sub', 'gpg.sub')
    run('gpg --import ~/gpg.s* &> /dev/null || rm ~/gpg.sub ~/gpg.sec*')
    local('rm ~/tmp/gpg.sub ~/tmp/gpg.sec')


def upload_ssh_key(name='id_rsa'):
    with open(os.path.expanduser('~/.ssh/%s.pub' % name)) as fd:
        key = fd.readline().strip()
    run('mkdir -p ~/.ssh && chmod 700 ~/.ssh')
    run("echo '%s' >> ~/.ssh/authorized_keys && chmod 644 ~/.ssh/authorized_keys" % key)


def install_remote_dotfiles(*args):
    tmp_dir = tempfile.mkdtemp()
    local("HOME=%s rake install components=vim,zsh,git,tools,bash remote=linux" % tmp_dir)
    local('find %s -name ".git" -delete' % tmp_dir)
    if args:
        for arg in args:
            put("%s/%s" % (tmp_dir, arg), "")
    else:
        put("%s/.*" % tmp_dir, "")
        put("%s/*" % tmp_dir, "")
    shutil.rmtree(tmp_dir)


# Hosts

def vagrant(path):
    env.user = 'vagrant'
    env.hosts = ['127.0.0.1:2222']
    res = local('cd %s && vagrant ssh-config | grep IdentityFile' % path, capture=True)
    env.key_filename = res.split()[1]
