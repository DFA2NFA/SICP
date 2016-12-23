#lang racket
(require "3_5_2_integers_by_add_streams.rkt")

(displayln "Start:")
(displayln "(stream-ref (add-streams integers integers) 10)")
(stream-ref (add-streams integers integers) 10)

(displayln "(display-stream (add-streams integers integers))")
(display-stream (add-streams integers integers))


(displayln "(stream-ref (add-streams integers integers) 10)")
(stream-ref (add-streams integers integers) 10)


(displayln "(stream-ref integers1 10)")
(stream-ref integers1 10)


(displayln "(stream-ref (add-streams integers1 integers1) 10)")
(stream-ref (add-streams integers1 integers1) 10)


(displayln "(stream-ref fibs 10)")
(stream-ref fibs 10)

(displayln "(define s (cons-stream 1 (lambda() (add-streams s s))))")
(define s (cons-stream 1 (lambda() (add-streams s s))))
(displayln "(stream-ref s 10)")
(stream-ref s 10)

(displayln "(stream-ref (add-streams-wrong-multi-stream-map integers integers) 10)")
(displayln "#you can see, even if you only need 10 items, it go through all")
(displayln "#you can open the dis to print the log")
(stream-ref (add-streams-wrong-multi-stream-map integers integers) 10)

;Start:
;(stream-ref (add-streams integers integers) 10)
;2
;4
;6
;8
;10
;12
;14
;16
;18
;20
;22
;(display-stream (add-streams integers integers))
;2
;4
;6
;8
;10
;12
;14
;16
;18
;20
;22
;24
;26
;28
;30
;32
;34
;36
;38
;40
;42
;44
;46
;48
;50
;52
;54
;56
;58
;60
;62
;64
;66
;68
;70
;72
;74
;76
;78
;80
;82
;84
;86
;88
;90
;92
;94
;96
;98
;100
;102
;104
;106
;108
;110
;112
;114
;116
;118
;120
;122
;124
;126
;128
;130
;132
;134
;136
;138
;140
;142
;144
;146
;148
;150
;152
;154
;156
;158
;160
;162
;164
;166
;168
;170
;172
;174
;176
;178
;180
;182
;184
;186
;188
;190
;192
;194
;196
;198
;200
;'done
;(stream-ref (add-streams integers integers) 10)
;2
;4
;6
;8
;10
;12
;14
;16
;18
;20
;22
;(stream-ref integers1 10)
;1
;2
;3
;4
;5
;6
;7
;8
;9
;10
;11
;(stream-ref (add-streams integers1 integers1) 10)
;2
;4
;6
;8
;10
;12
;14
;16
;18
;20
;22
;(stream-ref fibs 10)
;0
;1
;1
;2
;3
;5
;8
;13
;21
;34
;55
;(define s (cons-stream 1 (lambda() (add-streams s s))))
;(stream-ref s 10)
;1
;2
;4
;8
;16
;32
;64
;128
;256
;512
;1024
;(stream-ref (add-streams-wrong-multi-stream-map integers integers) 10)
;#you can see, even if you only need 10 items, it go through all
;#you can open the dis to print the log
;2
;4
;6
;8
;10
;12
;14
;16
;18
;20
;22