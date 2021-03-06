(label eval (lambda (expr binds)
              (cond
                ((atom expr) (assoc expr binds))
                ((atom (car expr))
                 (cond
                   ((eq (car expr) (quote quote)) (cadr expr))
                   ((eq (car expr) (quote atom))  (atom   (eval (cadr expr) binds)))
                   ((eq (car expr) (quote eq))    (eq     (eval (cadr expr) binds)
                                                          (eval (caddr expr) binds)))
                   ((eq (car expr) (quote car))   (car    (eval (cadr expr) binds)))
                   ((eq (car expr) (quote cdr))   (cdr    (eval (cadr expr) binds)))
                   ((eq (car expr) (quote cons))  (cons   (eval (cadr expr) binds)
                                                          (eval (caddr expr) binds)))
                   ((eq (car expr) (quote cond))  (eval-cond (cdr expr) binds))
                   (true (eval (cons (assoc (car expr) binds)
                                  (cdr expr))
                            binds))))
                ((eq (caar expr) (quote label))
                 (eval (cons (caddar expr) (cdr expr))
                       (cons (list (cadar expr) (car expr)) binds)))
                ((eq (caar expr) (quote lambda))
                 (eval (caddar expr)
                       (append (pair (cadar expr) (eval-args (cdr expr) binds))
                               binds)))
                ((eq (caar expr) (quote macro))
                 (cond
                   ((eq (cadar expr) (quote lambda))
                    (eval (eval (car (cdddar expr))
                                (cons (list (car (caddar expr))
                                             (cadr expr))
                                      binds))
                          binds)))))))

(label eval-cond (lambda (eval-cond_c eval-cond_a)
                   (cond ((eval (caar eval-cond_c) eval-cond_a)
                          (eval (cadar eval-cond_c) eval-cond_a))
                         (true (eval-cond (cdr eval-cond_c) eval-cond_a)))))

(label eval-args (lambda (eval-args_m eval-args_a)
                   (cond ((null eval-args_m) nil)
                         (true (cons (eval  (car eval-args_m) eval-args_a)
                                  (eval-args (cdr eval-args_m) eval-args_a))))))
