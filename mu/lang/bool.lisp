(label and (lambda (and_x and_y)
             (cond (and_x
                    (cond (and_y true)
                          (true nil)))
                   (true nil))))

(label not (lambda (not_x)
             (cond (not_x nil)
                   (true true))))

(label nand (lambda (nand_x nand_y)
              (not (and nand_x nand_y))))

(label or (lambda (or_x or_y)
            (nand
             (nand or_x or_x)
             (nand or_y or_y))))

(label nor (lambda (nor_x nor_y)
             (not (or nor_x nor_y))))

(label xor (lambda (xor_x xor_y)
             (or
              (and xor_x (not xor_y))
              (and (not xor_x) xor_y))))

(label and_ (lambda (x y) (cond (x (cond (y true) (true nil))) (true nil))))
(label not_ (lambda (x) (cond (x nil) (true true))))
(label nand_ (lambda (x y) (not_ (and_ x y))))
(label or_ (lambda (x y) (nand_ (nand_ x x) (nand_ y y))))
(label xor_ (lambda (x y) (or_ (and_ x (not_ y)) (and_ (not_ x) y))))
