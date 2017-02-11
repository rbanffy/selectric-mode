;;; selectric-mode.el --- IBM Selectric mode for Emacs  -*- lexical-binding: t; -*-

;; Author: Ricardo Bánffy <rbanffy@gmail.com>
;; Maintainer: Ricardo Banffy <rbanffy@gmail.com>
;; URL: https://github.com/rbanffy/green-screen-emacs
;; Keywords: multimedia, convenience, typewriter, selectric
;; Version: 1.0.0a

;; Copyright (C) 2015-2017  Ricardo Bánffy

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

(defvar selectric-mode-map (make-sparse-keymap) "Selectric mode's keymap.")

; Manually force DEL to make a sound.
(define-key selectric-mode-map (kbd "DEL")
  (lambda ()
    (interactive)
    (progn
      (selectric-move-sound)
      (backward-delete-char-untabify 1))))

; Manually force DELETE to make a sound.  Should also do it for C-d.
(define-key selectric-mode-map (kbd "<deletechar>")
  (lambda ()
    (interactive)
    (progn
      (selectric-move-sound)
      (delete-char 1))))

(defun selectric-make-sound (sound-file-name)
  "Play sound from file SOUND-FILE-NAME using platform-appropriate program."
  (if (eq system-type 'darwin)
      (start-process "*Messages*" nil "afplay" sound-file-name)
    (start-process "*Messages*" nil "aplay" sound-file-name)))

(defun selectric-type-sound ()
  "Make the sound of the printing element hitting the paper."
  (progn
    (selectric-make-sound (format "%sselectric-type.wav" selectric-files-path))
    (unless (minibufferp)
      (if (= (current-column) (current-fill-column))
            (selectric-make-sound (format "%sping.wav" selectric-files-path))))))

(defun selectric-move-sound ()
  "Carriage movement sound."
  (selectric-make-sound (format "%sselectric-move.wav" selectric-files-path)))

;;;###autoload
(define-minor-mode selectric-mode
  "Toggle Selectric mode.
Interactively with no argument, this command toggles the mode.  A
positive prefix argument enables the mode, any other prefix
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
  :keymap selectric-mode-map

  (if selectric-mode
      (progn
        (add-hook 'post-self-insert-hook 'selectric-type-sound)
        ; (global-set-key [left] (noisy-move 'left-char))
        (selectric-type-sound))
    (progn
      (remove-hook 'post-self-insert-hook 'selectric-type-sound)
      (selectric-move-sound)))
  )

(provide 'selectric-mode)
;;; selectric-mode.el ends here
