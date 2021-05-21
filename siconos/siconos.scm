; too many modules, to be cleaned
(define-module (siconos siconos)
  #:use-module (srfi srfi-1)
  #:use-module (ice-9 popen)
  #:use-module (ice-9 rdelim)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix hg-download)
  #:use-module (guix build-system python)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system trivial)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build rpath)
  #:use-module (gnu packages)
  #:use-module (gnu packages check)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages backup)
  #:use-module (gnu packages nettle)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages elf)
  #:use-module (gnu packages autogen)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages swig)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages swig)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages base)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages image)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages game-development))

(define-public fclib-3.0
  (package
    (name "fclib")
    (version "3.0.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/FrictionalContactLibrary/fclib/")
             (commit "079e4d221d19ed47c6c3457b50cdfcb3dfd7e28c")))
       (sha256 (base32
                "1zivxh404pk1gjiv32vgyg4dqzlkn0pm2hh5vv7ryahk48xk1flx"))))
    (build-system cmake-build-system)
    (arguments
     '(#:build-type "Release"           ;Build without '-g' to save space.
                    #:configure-flags
                    '("-DFCLIB_HEADER_ONLY=OFF")
                    #:tests? #f))
    (native-inputs
     `(("gcc" ,gcc)
       ("gnu-make" ,gnu-make)
       ("cmake" ,cmake)))
    (propagated-inputs
     `(("hdf5" ,hdf5)))
    (home-page "https://frictionalcontactlibrary.github.io/")
    (synopsis "A collection of discrete 3D Frictional Contact (FC) problems")
    (description "FCLIB is an open source collection of Frictional
Contact (FC) problems stored in a specific HDF5 format with a light
implementation in C Language of Input/Output functions to read and write those
problems.")
    (license license:asl2.0) ; Apache 2.0
    ))

(define-public fclib fclib-3.0)

(define-public siconos-tutorials-4.3
  (package
    (name "siconos-tutorials")
    (version "4.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/siconos/siconos-tutorials/archive/"
             version ".tar.gz"))
       (sha256 (base32
                "1ysaqchiafbaz285pr6rbhaba5k3skb8lgva23y0zy3dgjqj5fcc"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ((source (assoc-ref %build-inputs "source"))
                (out (assoc-ref %outputs "out"))
                (out-t (string-append out "/share/siconos/siconos-tutorials"))
                (tar (assoc-ref %build-inputs "tar"))
                (gzip  (assoc-ref %build-inputs "gzip")))
           (setenv "PATH" (string-append tar "/bin:" gzip "/bin"))
           (invoke "tar" "zxvf" source)
           (mkdir-p out-t)
           (copy-recursively (string-append "siconos-tutorials-" ,version)
                             out-t)))))
    (native-inputs
     `(("source" ,source)
       ("tar" ,tar)
       ("gzip" ,gzip)))
    (home-page "https://github.com/siconos/siconos-tutorials")
    (synopsis "Library for nonsmooth numerical simulation - Examples")
    (description
     "Siconos is an open-source scientific software primarily targeted at
modeling and simulating nonsmooth dynamical systems in C++ and in Python:
Mechanical systems (rigid or solid) with unilateral contact and Coulomb
friction and impact (nonsmooth mechanics, contact dynamics, multibody systems
dynamics or granular materials).  Switched Electrical Circuit such as
electrical circuits with ideal and piecewise linear components: power
converter, rectifier, Phase-Locked Loop (PLL) or Analog-to-Digital converter.
Sliding mode control systems.  Biology (Gene regulatory network).

Other applications are found in Systems and Control (hybrid systems,
differential inclusions, optimal control with state constraints),
Optimization (Complementarity systems and Variational inequalities), Fluid
Mechanics, and Computer Graphics.")
    (license license:asl2.0) ; Apache 2.0
    ))


(define-public siconos-tutorials siconos-tutorials-4.3)

(define-public siconos-4.3
  (package
    (name "siconos")
    (version "4.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/siconos/siconos/archive/"
             version ".tar.gz"))
       (sha256 (base32
                "0lksvbw4m3z938hsi3bs9zdbiq6ijgzdfqan0p7qhdsawhmzzzv2"))))
    (build-system cmake-build-system)
    (arguments
     '(#:configure-flags '("-DCMAKE_VERBOSE_MAKEFILE=ON"
                           "-DWITH_BULLET=ON"
                           "-DWITH_OCE=ON"
                           "-DWITH_FCLIB=ON"
                           "-DWITH_SYSTEM_SUITESPARSE=ON")
                         #:tests? #f))                              ;XXX: no "test" target
    (outputs '("out" "debug"))
    (native-inputs
     `(("swig" ,swig)
       ("gcc" ,gcc)
       ("gfortran" ,gfortran)
       ("gnu-make" ,gnu-make)
       ("cmake" ,cmake)
       ("python-pytest" ,python-pytest)))
    (inputs
     `(("python" ,python)))
    (propagated-inputs
     `(("boost" ,boost)
       ("bullet" ,bullet)
       ("fclib" ,fclib)
       ("gmp" ,gmp)
       ("lapack" ,lapack)
       ("openblas" ,openblas)
       ("opencascade-oce" ,opencascade-oce)
       ("python-h5py"  ,python-h5py)
       ("python-lxml"  ,python-lxml)
       ("python-numpy" ,python-numpy)
       ("python-packaging" ,python-packaging)
       ("python-scipy" ,python-scipy)
       ("suitesparse" ,suitesparse)))
    (home-page "https://nonsmooth.gricad-pages.univ-grenoble-alpes.fr/siconos/index.html")
    (synopsis "Library for nonsmooth numerical simulation")
    (description
     "Siconos is an open-source scientific software primarily targeted at
modeling and simulating nonsmooth dynamical systems in C++ and in Python:
Mechanical systems (rigid or solid) with unilateral contact and Coulomb
friction and impact (nonsmooth mechanics, contact dynamics, multibody systems
dynamics or granular materials).  Switched Electrical Circuit such as
electrical circuits with ideal and piecewise linear components: power
converter, rectifier, Phase-Locked Loop (PLL) or Analog-to-Digital converter.
Sliding mode control systems.  Biology (Gene regulatory network).

Other applications are found in Systems and Control (hybrid systems,
differential inclusions, optimal control with state constraints),
Optimization (Complementarity systems and Variational inequalities), Fluid
Mechanics, and Computer Graphics.")
    (license license:asl2.0) ; Apache 2.0
    ))

; with mumps and mpi
(define-public siconos-mpi-4.3
  (package
    (inherit siconos-4.3)
    (name "siconos-mpi")
    (synopsis "Library for nonsmooth numerical simulation - with MUMPS solver and MPI")
    (propagated-inputs
     `(("mpi" ,openmpi)
       ("mumps-openmpi" ,mumps-openmpi)
       ("python-mpi4py" ,python-mpi4py)
       ,@(package-propagated-inputs siconos-4.3)))
    (arguments
     `(#:configure-flags `("-DWITH_MPI=ON"
                           "-DWITH_MUMPS=ON" ,@configure-flags)
       #:tests? #f))))                              ;XXX: no "test" target

(define-public siconos-4.4-rc2
  (package
    (inherit siconos-4.3)
    (version "4.4.0.rc2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/siconos/siconos/archive/"
             version ".tar.gz"))
       (sha256 (base32
                "18z8bcl2b4l2iaw9f3hgafxsid8kyn5vdm07fl53whl3jac4xaca"))))))

(define-public siconos-4.4-rc3
  (package
    (inherit siconos-4.4-rc2)
    (version "4.4.0.rc3")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/siconos/siconos/archive/"
             version ".tar.gz"))
       (sha256 (base32
                "148fwppjj7rdiqrgapbm9rg4k60d8xm9q4fc3757fp236nv8bxip"))))))

(define-public siconos-mpi-4.4-rc2
  (package
    (inherit siconos-mpi-4.3)
    (version "4.4.0.rc2")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/siconos/siconos/archive/"
             version ".tar.gz"))
       (sha256 (base32
                "18z8bcl2b4l2iaw9f3hgafxsid8kyn5vdm07fl53whl3jac4xaca"))))))


(define-public siconos-mpi-4.4-rc3
  (package
    (inherit siconos-mpi-4.4-rc2)
    (version "4.4.0.rc3")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/siconos/siconos/archive/"
             version ".tar.gz"))
       (sha256 (base32
                "148fwppjj7rdiqrgapbm9rg4k60d8xm9q4fc3757fp236nv8bxip"))))))

(define-public siconos siconos-4.4-rc3)

(define-public siconos-mpi siconos-mpi-4.4-rc3)

(define-public pythonocc
  (package
    (name "pythonocc")
    (version "0.17.3")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/tpaviot/pythonocc-core/archive/" version ".tar.gz"))
       (sha256
        (base32
         "0fk617nlfh3c79wladgdl7jvbjs1dfqwncjalc456qlkb8ix8xci"))
       (patches
        (search-patches
         "pythonocc-install.patch"))))
    (native-inputs
     `(("cmake" ,cmake)
       ("make" ,gnu-make)
       ("swig" ,swig)
       ("gcc" ,gcc)))
    (inputs
     `(("python" ,python)
       ("freetype" ,freetype)
       ("mesa" ,mesa)
       ("glu" ,glu)
       ("opencascade-oce" ,opencascade-oce)))
    (build-system cmake-build-system)
    (arguments
     '(#:build-type "Release"           ;Build without '-g' to save space.
                    #:configure-flags
                    '()
                    #:tests? #f))
    (home-page "http://www.pythonocc.org/")
    (synopsis "3D CAD for python")
    (description
     "pythonOCC is a 3D CAD/PLM development library for the Python
programming language. It provides 3D hybrid modeling, data
exchange (support for the STEP/IGES file format), GUI management
support (wxPython, PyQt, python-xlib), parametric modeling, and
advanced meshing features. pythonOCC is built upon the OpenCASCADE 3D
modeling kernel and the salomegeom and salomesmesh packages. Some high
level packages (for parametric modeling, topology, data exchange,
webservices, etc.) extend the builtin features of those libraries to
enable highly dynamic and modular programming of any CAD application.")
    (license license:lgpl3)))

(define-public lmgc90
  (package
   (name "lmgc90")
   (version "2019.rc1")
   (source
    (origin
     (method url-fetch)
     (uri "https://seafile.lmgc.univ-montp2.fr/f/7ea37ca5a7ec469f9373/?dl=1")
     (sha256
      (base32
       "111g568404svzkq6ldnr2xxf7am2rmfaxvv11mwwxi5w5i1i6c8n"))))
   (build-system cmake-build-system)
   (native-inputs
    `(("fortran" ,gfortran)
      ("gcc" ,gcc)
      ("swig" ,swig)
      ("git" ,git)
      ("patchelf" ,patchelf)))
   (inputs
    `(("blas" ,openblas)
      ("python" ,python)
      ("gmsh" ,gmsh)
      ("mumps" ,mumps)
      ("siconos" ,siconos)
      ("numpy" ,python-numpy)))
   (arguments
     `(#:modules ((guix build cmake-build-system)
                  (guix build utils)
                  (guix build rpath)
                  (ice-9 match)
                  (ice-9 popen)
                  (srfi srfi-1))
       #:imported-modules (,@%cmake-build-system-modules
                           (guix build rpath))
      #:build-type
      "Release"           ;Build without '-g' to save space.
      #:configure-flags
      '("-DWITH_SICONOS_NUMERICS=1")
      #:tests? #f
      #:phases
      (modify-phases %standard-phases
        (add-after 'install 'fix-rpath
          (lambda* (#:key outputs #:allow-other-keys)
            (let* ((out (assoc-ref outputs "out"))
                   (libdir (string-append out "/lib")))
              (augment-rpath (string-append out "/lib/python"
                                            ,(version-major+minor
                                              (package-version python)) "/site-packages/pylmgc90/chipy/_lmgc90.so") libdir)))))))
   (home-page "https://git-xen.lmgc.univ-montp2.fr/lmgc90/lmgc90_user/wikis/home")
   (synopsis "LMGC90 is a free and open source software dedicated to
multiple physics simulation of discrete material and structures.")
   (description " The LMGC90 is a multipurpose software developed in
Montpellier, capable of modeling a collection of deformable or
undeformable particles of various shapes (spherical, polyhedral, or
non-convex) interacting trough simple interaction (friction,
cohesion...) or complex multiphysics coupling (fluid, thermal...)
")
   (license license:cecill)))


(define-public python-pyhull
  (package
   (name "python-pyhull")
   (version "2015.2.1")
   (source
    (origin
     (method url-fetch)
     (uri (pypi-uri "pyhull" version))
     (sha256
      (base32
       "091sph52c4yk1jlm5w8xidxpzbia9r7s42bnb23q4m4b56ihmzyj"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-numpy" ,python-numpy)))
   (home-page
    "https://github.com/materialsvirtuallab/pyhull")
   (synopsis
    "A Python wrapper to Qhull (http://www.qhull.org/) for the computation of the convex hull, Delaunay triangulation and Voronoi diagram")
   (description
    "A Python wrapper to Qhull (http://www.qhull.org/) for the computation of the convex hull, Delaunay triangulation and Voronoi diagram")
   (license license:expat)))

