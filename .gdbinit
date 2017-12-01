python
import sys, os.path
sys.path.insert(0, os.path.expanduser('~/scripts/development/gdb_pretty_printers'))
import qt5printers
qt5printers.register_printers(gdb.current_objfile())
end
