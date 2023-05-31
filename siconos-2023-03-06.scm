(list (channel
        (name 'guix-hpc)
        (url "https://gitlab.inria.fr/bremond/guix-hpc.git")
        (branch "add-siconos")
        (commit
          "1afe0499a94ca3e02f43631272e36c6755784a2a"))
      (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch "master")
        (commit
          "461577f0fce1b69a88a752857eeee2e9e1116d6c")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
