(defpackage :todomvc (:use :cl)
            (:export
             #:start))
(in-package :todomvc)

(defmacro defpage (name args &rest body)
  (declare (ignore args))
  `(hunchentoot:define-easy-handler (,(intern (string-upcase name))
                                     :uri ,(format nil "/~a" name)) ()
     (setf (hunchentoot:content-type*) "text/html")
     (whopper:with-whopper-output-to-string
       ,@body)))

(defpage "index" ()
  (<:html
    (<:head
      (<:meta :charset "utf-8")
      (<:title "Ember.js • TodoMVC")
      (<:link :rel "stylesheet" :href "style.css"))
    (<:body
      (<:section :id "todoapp"
        (<:header :id "header"
          (<:h1 "todos")
          (<:input :type "text" :id "new-todo" :placeholder "What needs to be done?"))
        (<:section :id "main"
          (<:ul :id "todo-list"
            (<:li :class "completed"
              (<:input :type "checkbox" :class "toggle")
              (<:label "Learn Ember.js")
              (<:button :class "destroy"))
            (<:li
              (<:input :type "checkbox" :class "toggle")
              (<:label "...")
              (<:button :class "destroy"))
            (<:li
              (<:input :type "checkbox" :class "toggle")
              (<:label "Profit!")
              (<:button :class "destroy")))
          (<:input :type "checkbox" :id "toggle-all"))
        (<:footer :id "footer"
          (<:span :id "todo-count"
            (<:strong "2") "todos left")
          (<:ul :id "filters"
            (<:li
              (<:a :href "all" :class "selected" "All"))
            (<:li
              (<:a :href "active" "Active"))
            (<:li
              (<:a :href "completed" "Completed")))
          (<:button :id "clear-completed" "Clear completed (1)")))
        (<:footer :id "info"
          (<:p "Double-click to edit a todo")))))

(defparameter *acceptor* nil)

(defun start (&key (port 4242))
  (when *acceptor*
    (ignore-errors (hunchentoot:stop *acceptor*)))
  (hunchentoot:start
   (setq *acceptor*
         (make-instance 'hunchentoot:easy-acceptor :port port
                                                   :document-root "~/Sites/todomvc/"))))








