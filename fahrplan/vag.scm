(use medea http-client miscmacros uri-common udp tcp)

#;(determine-proxy
 (lambda (u) (uri-reference "http://proxy:3128/")))

(define (cleanup-times entry)
  (let* ((t-ist (string->time (alist-ref 'AbfahrtszeitIst entry) "%Y-%m-%dT%T%z"))
        (t-soll (string->time (alist-ref 'AbfahrtszeitSoll entry) "%Y-%m-%dT%T%z"))
        (verspaetung (modulo (- (local-time->seconds t-ist) (local-time->seconds t-soll)) 60)))
    (vector-set! t-ist 8 #t)
    (vector-set! t-soll 8 #t)
    (cons (cons 'Verspaetung verspaetung)
          (alist-update 'AbfahrtszeitIst (local-time->seconds t-ist)
                        (alist-update 'AbfahrtszeitSoll (local-time->seconds t-soll) entry)))))

(define (get-departures station-id)
      (let* ((res (with-input-from-request
                   (sprintf "http://start.vag.de/dm/api/v1/abfahrten/VGN/~a?product=Bus%2CTram%2CUBahn%2CSBahn%2CRBahn&timespan=30&limitcount=50" station-id)
                   #f read-json))
             (departures (alist-ref 'Abfahrten res)))
         (cons (cons 'Haltestelle (alist-ref 'Haltestellenname res))
              `((Abfahrten . ,(list->vector (map cleanup-times (vector->list departures))))))))



(define (send-time)
  (let ((s (udp-open-socket)))
    (udp-bind! s #f 0)
    (udp-connect! s "127.0.0.1" 4444)
    (udp-send s (sprintf "fahrplan/seconds/set:~a\n" (current-seconds)))
    (udp-send s (sprintf "fahrplan/clock/set:~a\n" (time->string (seconds->local-time (current-seconds)) "%T")))
    (udp-close-socket s)))

  (let loop ()
    (send-time)
    (let ((deps (get-departures 510)))
      (define-values (in out) (tcp-connect "localhost" 4444))
      (print (read-line in))
      (display "fahrplan" out)(newline out)
      (print (read-line in))
      (write-json deps out)
      (newline out)
      (close-input-port in)
      (close-output-port out)
      (repeat 60
              (send-time)
              (sleep 1))
      (loop)))


