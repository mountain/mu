(label list (lambda (x y)
              (cons x (cons y (quote ())))))

(label pair (lambda (x y)
              (cond ((and (null x) (null y)) nil)
                    ((and (not (atom x)) (not (atom y)))
                     (cons (list (car x) (car y))
                           (pair (cdr x) (cdr y)))))))

(label assoc (lambda (x y)
               (cond ((eq (car (car y)) x) (car (cdr (car y))))
                     (true (assoc x (cdr y))))))

(label caar (lambda (x) (car (car x))))
(label cadr (lambda (x) (car (cdr x))))
(label caddr (lambda (x) (car (cdr (cdr x)))))
(label cadar (lambda (x) (car (cdr (car x)))))
(label caddar (lambda (x) (car (cdr (cdr (car x))))))
(label cadddar (lambda (x) (car (cdr (cdr (cdr (car x)))))))

(label null (lambda (null_x)
              (eq null_x nil)))

(label mapcar (lambda (mapcar_f mapcar_lst)
                (cond
                  ((null mapcar_lst) mapcar_lst)
                  (true (cons
                      (mapcar_f (car mapcar_lst))
                      (mapcar mapcar_f (cdr mapcar_lst)))))))

(label reduce (lambda (reduce_f reduce_lst)
                (cond
                  ((null reduce_lst) (reduce_f))
                  (true (reduce_f (car reduce_lst)
                               (reduce reduce_f (cdr reduce_lst)))))))

(label append (lambda (append_x append_y)
                (cond ((null append_x) append_y)
                      (true (cons (car append_x)
                               (append (cdr append_x) append_y))))))

(label filter (lambda (filter_f filter_lst)
                (cond
                  ((null filter_lst) filter_lst)
                  (true (cond
                       ((filter_f (car filter_lst)) (cons
                                                     (car filter_lst)
                                                     (filter filter_f (cdr filter_lst))))
                       (true (filter filter_f (cdr filter_lst))))))))


(label apply (lambda (apply_name apply_args)
               ((list apply_name (list (quote quote) apply_args)))))

