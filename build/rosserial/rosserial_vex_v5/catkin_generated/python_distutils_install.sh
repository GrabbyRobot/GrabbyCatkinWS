#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/julius_robo3/GrabbyCatkinWS/src/rosserial/rosserial_vex_v5"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/julius_robo3/GrabbyCatkinWS/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/julius_robo3/GrabbyCatkinWS/install/lib/python2.7/dist-packages:/home/julius_robo3/GrabbyCatkinWS/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/julius_robo3/GrabbyCatkinWS/build" \
    "/usr/bin/python2" \
    "/home/julius_robo3/GrabbyCatkinWS/src/rosserial/rosserial_vex_v5/setup.py" \
     \
    build --build-base "/home/julius_robo3/GrabbyCatkinWS/build/rosserial/rosserial_vex_v5" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/julius_robo3/GrabbyCatkinWS/install" --install-scripts="/home/julius_robo3/GrabbyCatkinWS/install/bin"
