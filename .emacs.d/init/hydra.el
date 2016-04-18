;; Hydra
(require 'hydra-examples)
(defhydra hydra-splitter (global-map "C-c y o")
    "splitter"
    ("h" hydra-move-splitter-left)
    ("j" hydra-move-splitter-down)
    ("k" hydra-move-splitter-up)
    ("l" hydra-move-splitter-right))
