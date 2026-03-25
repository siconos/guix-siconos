;; https://guix.bordeaux.inria.fr/eval/9029823
;; 2025-10-29 13:40:39

(list (channel
        (name 'guix-science)
        (url "https://codeberg.org/guix-science/guix-science.git")
        (branch "master")
        (commit
          "bf921f7e84953f940a63b81c2ec9804d5ccaf586")
        (introduction
          (make-channel-introduction
            "b1fe5aaff3ab48e798a4cce02f0212bc91f423dc"
            (openpgp-fingerprint
              "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446"))))
      (channel
        (name 'guix-science-nonfree)
        (url "https://codeberg.org/guix-science/guix-science-nonfree.git")
        (branch "master")
        (commit
          "53c488dd622d83c5c19705f0f95d48d9d5bc3720")
        (introduction
          (make-channel-introduction
            "58661b110325fd5d9b40e6f0177cc486a615817e"
            (openpgp-fingerprint
              "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446"))))
      (channel
        (name 'guix-hpc)
        (url "https://gitlab.inria.fr/guix-hpc/guix-hpc.git")
        (branch "master")
        (commit
          "641e030a8bebfeaa43ca2ff12cab66763ec57aa4"))
      (channel
        (name 'guix-hpc-non-free)
        (url "https://gitlab.inria.fr/guix-hpc/guix-hpc-non-free.git")
        (branch "master")
        (commit
          "d96a225137d7934477bcf53bfab591b3b1871896"))
      (channel
        (name 'guix)
        (url "https://git.guix.gnu.org/guix.git")
        (branch "master")
        (commit
          "df23a503998a210697f49a169ab314039889515b")
        (introduction
          (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
              "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
      (channel
        (name 'guix-past)
        (url "https://codeberg.org/guix-science/guix-past.git")
        (branch "master")
        (commit
          "c3bc94ee752ec545e39c1b8a29f739405767b51c")
        (introduction
          (make-channel-introduction
            "0c119db2ea86a389769f4d2b9c6f5c41c027e336"
            (openpgp-fingerprint
              "3CE4 6455 8A84 FDC6 9DB4  0CFB 090B 1199 3D9A EBB5")))))
