(setq calendar-date-style 'iso)
(setq calendar-week-start-day 1)

(add-hook 'calendar-load-hook
          (lambda ()
            (calendar-set-date-style 'iso)))

(setq holiday-general-holidays
      '((holiday-fixed 1 1 "Neujahr")
        (holiday-fixed 5 1 "1. Mai")
        (holiday-fixed 10 3 "Tag der Deutschen Einheit")))

(setq holiday-christian-holidays
      '(
        ;; (holiday-float 12 0 -4 "1. Advent" 24)
        ;; (holiday-float 12 0 -3 "2. Advent" 24)
        ;; (holiday-float 12 0 -2 "3. Advent" 24)
        ;; (holiday-float 12 0 -1 "4. Advent" 24)
        (holiday-fixed 12 25 "1. Weihnachtstag")
        (holiday-fixed 12 26 "2. Weihnachtstag")
        ;; (holiday-fixed 1 6 "Heilige Drei Könige")
        (holiday-easter-etc -48 "Rosenmontag")
        ;; (holiday-easter-etc -3 "Gründonnerstag")
        (holiday-easter-etc  -2 "Karfreitag")
        (holiday-easter-etc   0 "Ostersonntag")
        (holiday-easter-etc  +1 "Ostermontag")
        (holiday-easter-etc +39 "Christi Himmelfahrt")
        (holiday-easter-etc +49 "Pfingstsonntag")
        (holiday-easter-etc +50 "Pfingstmontag")
        (holiday-easter-etc +60 "Fronleichnam")
        ;; (holiday-fixed 8 15 "Mariae Himmelfahrt")
        (holiday-fixed 11 1 "Allerheiligen")
        ;; (holiday-float 11 3 1 "Buss- und Bettag" 16)
        ;; (holiday-float 11 0 1 "Totensonntag" 20)
        ))
