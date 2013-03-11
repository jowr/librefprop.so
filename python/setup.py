
# This is the setup script for my python library. It is based 
# on a couple of online articles, but I mostly recycled ideas
# from   http://wiki.cython.org/PackageHierarchy
# and    http://pdsim.sourceforge.net/

# Get general includes
import sys, os

## Manage the imports and give proper error messages
## in case something goes wrong.
#try:
#    import Cython
#except:
#    raise ImportError('Cython is missing, visit http://www.cython.org or run pip install cython')
#    sys.exit(1)
#    
#try:
#    import ctypes
#except:
#    raise ImportError('ctypes is missing, run pip install ctypes')
#    sys.exit(1)

# Get the includes for this script
from distutils.core import setup
#from setuptools import setup
from distutils.extension import Extension
#from Cython.Distutils import build_ext

# Define an additional include directory
addIncludeDir = "/usr/local/include"


# scan the directory for extension files, converting
# them to extension names in dotted notation
def scandir(myDir, files=[]):
    for myFile in os.listdir(myDir):
        path = os.path.join(myDir, myFile)
        if os.path.isfile(path) and path.endswith(".pyx"):
            files.append(path.replace(os.path.sep, ".")[:-4])
        elif os.path.isdir(path):
            scandir(path, files)
    return files


# generate an Extension object from its dotted name
def makeExtension(extName):
    extPath = extName.replace(".", os.path.sep)+".pyx"
    return Extension(
        extName,
        [extPath],
        include_dirs = [addIncludeDir, "."],   # adding the '.' to include_dirs is CRUCIAL!!
        extra_compile_args = ["-O3", "-Wall"],
        extra_link_args = ['-g'],
        libraries = ["refprop",],
        )

# get the list of extensions
extNames = scandir("pyrp")

# and build up the set of Extension objects
extensions = [makeExtension(name) for name in extNames]

# Direct access to regularly changed entries
version = "0.1"
packages= ["pyrp"]
#depends = ['nose','ctypes','Cython']

# finally, we can pass all this to distutils
setup(
  name         = "pyrp",
  version      = version,
  author       = "Jorrit Wronski",
  author_email = "jowr@mek.dtu.dk",
  url          = "http://tes.mek.dtu.dk",
  description  = "Functions and examples that help you to access Refprop from Python.",
  packages     = packages,
#  cmdclass     = {"build_ext": build_ext},
  ext_modules  = extensions,
)

