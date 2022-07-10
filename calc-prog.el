;;; calc-prog.el --- Calc programmers utilities -*- lexical-binding: t -*-

;; Author: Jesse Millwood
;; Maintainer: Jesse Millwood
;; Version: 0.1
;; Homepage: https://github.com/Jesse-Millwood/calc-prog
;; Keywords: tools, convenience
;; Package-Requires: ((emacs "24.1"))


;; This file is not part of GNU Emacs

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.


;;; Commentary:

;; This package provides utilities for programmers using calc.
;; The added features to calc are:
;;  - Added common IEC binary units
;;    - Multi-byte units found at
;;      https://en.wikipedia.org/wiki/Byte#Multiple-byte_units
;;  - Easier shifting function
;;  - Masking functions
;;  - Better kill/yank functions


;;; Code:
(require 'calc-units)

;; convert between iec representation to hex
;; To use:
;;  - Enter Algebra mode: '
;;  - Enter number: 64 MiB
;;  - Convert to byte: u c Byte
;;  - Display in binary: d 2
;;  - Show grouping: d g
(setq math-additional-units '(
  (PiB "(1024 ^ 5) * Byte" "IEC Pebibyte")
  (TiB "(1024 ^ 4) * Byte" "IEC Tebibyte")
  (GiB "(1024 ^ 3) * Byte" "IEC Gibibbyte")
  (MiB "(1024 ^ 2) * Byte" "IEC Mebibyte")
  (KiB "1024 * Byte" "IEC Kibibyte 1024 bytes")
  (Byte "8 * bit" "A byte is the usual grouping of bits to be used in computational storage")
  (bit nil "The most basic computational storage unit")))
(setq math-units-table nil)

;;;###autoload
(defmath prog-shift-left-by (number shift)
  "Take first two items on the stack.  Logical shift NUMBER by SHIFT bits to left and return."
  (interactive 2 "l-shft")
  (lsh number shift))

;;;###autoload
(defmath prog-shift-right-by (number shift)
  "Take first two items on the stack.  Logical shift NUMBER by SHIFT bits to right and return."
  (interactive 2 "r-shft")
  (lsh number (* -1 shift)))

;;;###autoload
(defmath prog-mask (number mask)
  "Take first two items on the stack.  Apply the MASK to the NUMBER with an AND operation and return the result."
  (interactive 2 "Masked")
  (logand number mask))

;;;###autoload
(defmath prog-hex-kill (n)
  "Kill the number on the top of the stack as the hex representation."
  (interactive 1 "hex-kill")
  (message "hello")
  (kill-new (format "0x%X" n))
  (+ 0 n))

(provide 'calc-prog)

;;; calc-prog.el ends here
