(defparameter *field-width* 35)
(defparameter *field-height* 35)


(defclass lifegame ()
  (field epoch))

(defmethod init-field ((x lifegame))
  (setf (slot-value x 'epoch) 0)
  (setq tmp (make-array (list *field-height* *field-width*)
                        :initial-element 0 :element-type 'fixnum))
  (dotimes (i *field-height*)
    (dotimes (j *field-width*)
      (setf (aref tmp i j) (round (* 0.7 (random 1.0))))))
  (setf (slot-value x 'field) tmp))

(defmethod show-field ((x lifegame))
  (format *standard-output* "epoch: ~A~%" (slot-value x 'epoch))
  (dotimes (i *field-height*)
    (dotimes (j *field-width*)
      (if (eq (aref (slot-value x 'field) i j) 1)
        (format *standard-output* "■ ")
        (format *standard-output* "□ ")))
    (format *standard-output* "~%")))

(defmethod next-step ((x lifegame))
  (dotimes (i *field-height*)
    (dotimes (j *field-width*)
      (setq tmp (+ (top-left x i j)
                   (top x i j)
                   (top-right x i j)
                   (left x i j)
                   (right x i j)
                   (bottom-left x i j)
                   (bottom x i j)
                   (bottom-right x i j)))
      (if (eq 0 (aref (slot-value x 'field) i j))
        (if (eq 3 tmp)
          (setf (aref (slot-value x 'field) i j) 1))
        (if (or (<= 4 tmp) (>= 1 tmp))
          (setf (aref (slot-value x 'field) i j) 0)))))
  (incf (slot-value x 'epoch)))

(defun top-left ((x lifegame) i j)
  (if (or (eq i 0) (eq j 0)) 0 (aref (slot-value x 'field) (1- i) (1- j))))
(defun top ((x lifegame) i j)
  (if (eq i 0) 0 (aref (slot-value x 'field) (1- i) j)))
(defun top-right ((x lifegame) i j)
  (if (or (eq i 0) (eq j (1- *field-width*))) 0 (aref (slot-value x 'field) (1- i) (1+ j))))
(defun left ((x lifegame) i j)
  (if (eq j 0) 0 (aref (slot-value x 'field) i (1- j))))
(defun right ((x lifegame) i j)
  (if (eq j (1- *field-width*)) 0 (aref (slot-value x 'field) i (1+ j))))
(defun bottom-left ((x lifegame) i j)
  (if (or (eq i (1- *field-height*)) (eq j 0)) 0 (aref (slot-value x 'field) (1+ i) (1- j))))
(defun bottom ((x lifegame) i j)
  (if (eq i (1- *field-height*)) 0 (aref (slot-value x 'field) (1+ i) j)))
(defun bottom-right ((x lifegame) i j)
  (if (or (eq i (1- *field-height*)) (eq j (1- *field-width*))) 0 (aref (slot-value x 'field) (1+ i) (1+ j))))


;; main
(defun main ()
  (setq l (make-instance 'lifegame))
  (init-field l)
  (dotimes (i 2000)
    (show-field l)
    (sleep 1)
    (next-step l)))

(ext:saveinitmem "lifegame"
                 :quiet t
                 :norc t
                 :init-function #'main
                 :executable t)

