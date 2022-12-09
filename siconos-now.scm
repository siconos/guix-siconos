;; This is not a reproductible channels specification as there is no
;; commit constraints on both guix-siconos and guix channels
(cons
 (channel
  (name 'guix-hpc)
  (url "https://gitlab.inria.fr/bremond/guix-hpc.git")
  (branch "add-siconos"))
 %default-channels)
