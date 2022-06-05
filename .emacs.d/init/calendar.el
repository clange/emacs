(use-package german-holidays
  :ensure t)

(setq calendar-date-style 'iso)
(setq calendar-week-start-day 1)

(add-hook 'calendar-load-hook
          (lambda ()
            (calendar-set-date-style 'iso)))

(setq calendar-holidays holiday-german-NW-holidays)
