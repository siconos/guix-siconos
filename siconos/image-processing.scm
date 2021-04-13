;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2017 John Darrington <jmd@gnu.org>
;;; Copyright © 2017, 2019 Ricardo Wurmus <rekado@elephly.net>
;;; Copyright © 2014, 2021 Ludovic Courtès <ludo@gnu.org>
;;; Copyright © 2014 Mark H Weaver <mhw@netris.org>
;;; Copyright © 2016 Eric Bavier <bavier@member.fsf.org>
;;; Copyright © 2018–2021 Tobias Geerinckx-Rice <me@tobias.gr>
;;; Copyright © 2018 Björn Höfling <bjoern.hoefling@bjoernhoefling.de>
;;; Copyright © 2018 Lprndn <guix@lprndn.info>
;;; Copyright © 2019, 2021 Efraim Flashner <efraim@flashner.co.il>
;;; Copyright © 2020 Vincent Legoll <vincent.legoll@gmail.com>
;;; Copyright © 2020, 2021 Vinicius Monego <monego@posteo.net>
;;; Copyright © 2020 Pierre Neidhardt <mail@ambrevar.xyz>
;;; Copyright © 2020 Brendan Tildesley <mail@brendan.scot>
;;; Copyright © 2021 Oleh Malyi <astroclubzp@gmail.com>
;;; Copyright © 2021 Felix Gruber <felgru@posteo.net>
;;; Copyright © 2021 Andy Tai <atai@atai.org>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.


;; python support for vtk (9 & 8)

(define-module (siconos image-processing)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system qt)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages geo)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages photo)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages video)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-1))

; modified version with python support
(define-public vtk
  (package
    (name "vtk")
    (version "9.0.1")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://vtk.org/files/release/"
                                  (version-major+minor version)
                                  "/VTK-" version ".tar.gz"))
              (sha256
               (base32
                "1ir2lq9i45ls374lcmjzw0nrm5l5hnm1w47lg8g8d0n2j7hsaf8v"))
              (patches
               (search-patches "vtk-fix-freetypetools-build-failure.patch"))
              (modules '((guix build utils)))
              (snippet
               '(begin
                  (for-each
                    (lambda (dir)
                      (delete-file-recursively
                        (string-append "ThirdParty/" dir "/vtk" dir)))
                    ;; pugixml depended upon unconditionally
                    '("doubleconversion" "eigen" "expat" "freetype" "gl2ps"
                      "glew" "hdf5" "jpeg" "jsoncpp" "libproj" "libxml2" "lz4"
                      "netcdf" "ogg" "png" "sqlite" "theora" "tiff" "zlib"))
                  #t))))
    (properties `((release-monitoring-url . "https://vtk.org/download/")))
    (build-system cmake-build-system)
    (arguments
     '(#:build-type "Release"           ;Build without '-g' to save space.
       #:configure-flags '(;"-DBUILD_TESTING:BOOL=TRUE"
                           ;    ; not honored
                           "-DVTK_USE_EXTERNAL=OFF" ;; default
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_doubleconversion=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_eigen=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_expat=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_freetype=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_gl2ps=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_glew=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_hdf5=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_jpeg=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_jsoncpp=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_libproj=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_libxml2=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_lz4=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_netcdf=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_ogg=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_png=ON"
                           ;"-DVTK_MODULE_USE_EXTERNAL_VTK_pugixml=ON"    ; breaks IO/CityGML
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_sqlite=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_theora=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_tiff=ON"
                           "-DVTK_MODULE_USE_EXTERNAL_VTK_zlib=ON"
                           "-DVTK_WRAP_PYTHON=ON"
                           "-DVTK_PYTHON_VERSION:STRING=3"
	                   "-DPython_ADDITIONAL_VERSIONS=3.8.2"
                           )
       #:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'patch-sources
             (lambda _
               (substitute* "Common/Core/vtkFloatingPointExceptions.cxx"
                 (("<fenv.h>") "<cfenv>"))
               (substitute* "Common/Core/CMakeLists.txt"
                 (("fenv.h") "cfenv")))))
       #:tests? #f))        ;XXX: test data not included
    (inputs
     `(("double-conversion" ,double-conversion)
       ("eigen" ,eigen)
       ("expat" ,expat)
       ("freetype" ,freetype)
       ("gl2ps" ,gl2ps)
       ("glew" ,glew)
       ("glu" ,glu)
       ("hdf5" ,hdf5)
       ("jpeg" ,libjpeg-turbo)
       ("jsoncpp" ,jsoncpp)
       ("libtheora" ,libtheora)
       ("libX11" ,libx11)
       ("libxml2" ,libxml2)
       ("libXt" ,libxt)
       ("lz4" ,lz4)
       ("mesa" ,mesa)
       ("netcdf" ,netcdf)
       ("png" ,libpng)
       ("python" ,python)
       ("proj" ,proj.4)
       ;("pugixml" ,pugixml)
       ("sqlite" ,sqlite)
       ("tiff" ,libtiff)
       ("xorgproto" ,xorgproto)
       ("zlib" ,zlib)))
    (propagated-inputs
     ;; VTK's 'VTK-vtk-module-find-packages.cmake' calls
     ;; 'find_package(THEORA)', which in turns looks for libogg.
     `(("libogg" ,libogg)))
    (home-page "https://vtk.org/")
    (synopsis "Libraries for 3D computer graphics")
    (description
     "The Visualization Toolkit (VTK) is a C++ library for 3D computer graphics,
image processing and visualization.  It supports a wide variety of
visualization algorithms including: scalar, vector, tensor, texture, and
volumetric methods; and advanced modeling techniques such as: implicit
modeling, polygon reduction, mesh smoothing, cutting, contouring, and Delaunay
triangulation.  VTK has an extensive information visualization framework, has
a suite of 3D interaction widgets, supports parallel processing, and
integrates with various databases on GUI toolkits such as Qt and Tk.")
    (license license:bsd-3)))


; with python support
(define-public vtk-8-2.0
  (package
    (name "vtk")
    (version "8.2.0")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://vtk.org/files/release/"
                                  (version-major+minor version)
                                  "/VTK-" version ".tar.gz"))
              (sha256
               (base32
                "1fspgp8k0myr6p2a6wkc21ldcswb4bvmb484m12mxgk1a9vxrhrl"))
              (patches
               (search-patches "vtk-8.2.0-fix-freetypetools-build-failure.patch"
                                "0001-Compatibility-for-Python-3.8.patch"))))
    (build-system cmake-build-system)
    (arguments
     '(#:build-type "Release"           ;Build without '-g' to save space.
       ;; -DVTK_USE_SYSTEM_NETCDF:BOOL=TRUE requires netcdf_cxx
       #:configure-flags '("-DVTK_USE_SYSTEM_EXPAT:BOOL=TRUE"
                           "-DVTK_USE_SYSTEM_FREETYPE:BOOL=TRUE"
                           "-DVTK_USE_SYSTEM_HDF5:BOOL=TRUE"
                           "-DVTK_USE_SYSTEM_JPEG:BOOL=TRUE"
                           "-DVTK_USE_SYSTEM_JSONCPP:BOOL=TRUE"
                           "-DVTK_USE_SYSTEM_LIBXML2:BOOL=TRUE"
                           "-DVTK_USE_SYSTEM_OGGTHEORA:BOOL=TRUE"
                           "-DVTK_USE_SYSTEM_PNG:BOOL=TRUE"
                           "-DVTK_USE_SYSTEM_TIFF:BOOL=TRUE"
                           "-DVTK_USE_SYSTEM_ZLIB:BOOL=TRUE"
                           "-DVTK_WRAP_PYTHON=ON"
                           "-DVTK_PYTHON_VERSION:STRING=3"
	                   "-DPython_ADDITIONAL_VERSIONS=3.8")
       #:tests? #f))                              ;XXX: no "test" target
    (inputs
     `(("libXt" ,libxt)
       ("xorgproto" ,xorgproto)
       ("libX11" ,libx11)
       ("libxml2" ,libxml2)
       ("mesa" ,mesa)
       ("glu" ,glu)
       ("expat" ,expat)
       ("freetype" ,freetype)
       ("hdf5" ,hdf5)
       ("jpeg" ,libjpeg-turbo)
       ("jsoncpp" ,jsoncpp)
       ("libogg" ,libogg)
       ("libtheora" ,libtheora)
       ("png" ,libpng)
       ("python" ,python)
       ("tiff" ,libtiff)
       ("zlib" ,zlib)))
    (home-page "https://vtk.org/")
    (synopsis "Libraries for 3D computer graphics")
    (description
     "The Visualization Toolkit (VTK) is a C++ library for 3D computer graphics,
image processing and visualization.  It supports a wide variety of
visualization algorithms including: scalar, vector, tensor, texture, and
volumetric methods; and advanced modeling techniques such as: implicit
modeling, polygon reduction, mesh smoothing, cutting, contouring, and Delaunay
triangulation.  VTK has an extensive information visualization framework, has
a suite of 3D interaction widgets, supports parallel processing, and
integrates with various databases on GUI toolkits such as Qt and Tk.")
    (license license:bsd-3)))


