;;; selectric-mode.el --- IBM Selectric mode for Emacs  -*- lexical-binding: t; -*-

;; Copyright (C) 2015  Ricardo Bánffy

;; Author: Ricardo Bánffy <rbanffy@gmail.com>
;; Keywords: multimedia, convenience, typewriter, selectric

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This minor mode plays the sound of an IBM Selectric typewriter as
;; you type.

;;; Code:

(defconst selectric-files-path (file-name-directory load-file-name))

(defun selectric-type-sound ()
  (if (eq system-type 'darwin)
      (start-process "*Messages*" nil "afplay" (format "%sselectric-type.wav"
                                                       selectric-files-path))
      (start-process "*Messages*" nil "aplay" (format "%sselectric-type.wav"
                                                       selectric-files-path))))

;;;autoload
(defun selectric-move-sound ()
  (if (eq system-type 'darwin)
      (start-process "*Messages*" nil "afplay" (format "%sselectric-move.wav"
                                                       selectric-files-path))
      (start-process "*Messages*" nil "aplay" (format "%sselectric-move.wav"
                                                       selectric-files-path))))

(define-minor-mode selectric-mode
  "Toggle Selectric mode.
Interactively with no argument, this command toggles the mode.
A positive prefix argument enables the mode, any other prefix
argument disables it.  From Lisp, argument omitted or nil enables
the mode, `toggle' toggles the state.

When Selectric mode is enabled, your Emacs will sound like an IBM
Selectric typewriter."
  :global t
  ;; The initial value.
  :init-value nil
  ;; The indicator for the mode line.
  :lighter " Selectric"
  :group 'selectric

  (if selectric-mode
      (progn
        (add-hook 'post-self-insert-hook 'selectric-type-sound)
        (selectric-type-sound))
      (progn
        (remove-hook 'post-self-insert-hook 'selectric-type-sound)
        (selectric-move-sound)))
  )

(provide 'selectric-mode)
;;; selectric-mode.el ends here
