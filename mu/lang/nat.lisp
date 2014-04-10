
(label zero (lambda (s z) z))
(label one (lambda (s z) (s z)))
(label plus (lambda (m n) (lambda (f x) (m f (n f x)))))
