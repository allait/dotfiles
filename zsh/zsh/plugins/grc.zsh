colourify () {
    grc -es --colour=auto $@
}

configure () {colourify ./configure $@}
diff () {colourify diff $@}
make () {colourify make $@}
gcc () {colourify gcc $@}
g++ () {colourify g++ $@}
as () {colourify as $@}
gas () {colourify gas $@}
ld () {colourify ld $@}
netstat () {colourify netstat $@}
ping () {colourify ping $@}
traceroute () {colourify /usr/sbin/traceroute $@}
