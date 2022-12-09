(list (channel
        (name 'guix-hpc)
        (url "https://gitlab.inria.fr/bremond/guix-hpc.git")
        (branch "add-siconos")
        (commit
          "2e0ca5b0ac90f9cc62a0d8e02617de2b5d883111"))
      (channel
        (name 'guix)
        (url "https://git.savannah.gnu.org/git/guix.git")
        (branch "master")
        (commit
          "3b3cc9dfed30afec70a6feaced3710bf79f8b2bc")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA")))))
