#!/Library/Frameworks/Python.framework/Versions/3.2/bin/python3.2
"""Logoclok

"CLOCK",", (screen saver)","","LOGOCLOK"
"SCREEN SAVER",", (analog clock)","","LOGOCLOK"
"""
import math
import datetime
import turtle

R = turtle.window_height()//2-8

def tick_lines():
    """Tick lines around the face."""
    for t in range(60):
        ha_r= math.radians(90-t*6)
        y_t_o = R*math.sin( ha_r )
        x_t_o = R*math.cos( ha_r )
        if t % 5 == 0:
            # Long thick mark each minute
            turtle.pensize(3)
            y_t_i = .95*R*math.sin( ha_r )
            x_t_i = .95*R*math.cos( ha_r )
        else:
            # Short thin mark each second
            turtle.pensize(1)
            y_t_i = .97*R*math.sin( ha_r )
            x_t_i = .97*R*math.cos( ha_r )
        turtle.penup(); turtle.goto( x_t_i, y_t_i )
        turtle.pendown(); turtle.goto( x_t_o, y_t_o )

def tick_circles():
    """Tick circles around the face."""
    for t in range(60):
        ha_r= math.radians(90-t*6)
        y_t_i = round((R-12)*math.sin( ha_r ))
        x_t_i = round((R-12)*math.cos( ha_r ))
        if t % 5 == 0:
            # Thick circle on the minute
            turtle.pensize(3)
        else:
            # Thin circle each second
            turtle.pensize(1)
        turtle.penup(); turtle.goto( x_t_i, y_t_i-turtle.pensize() )
        turtle.pendown(); turtle.circle( turtle.pensize()*2 )

def face( marks=tick_lines ):
    """Draw the face of the clock.

    :param marks: A function to draw marks around
         the face.
    """
    turtle.setundobuffer( None )

    turtle.title("HamCalc logoclok")
    turtle.hideturtle()
    turtle.pensize(4)
    turtle.penup()
    turtle.goto( 0, -R )
    turtle.pendown()
    turtle.circle( R, steps=60 )
    turtle.pensize(1)

    marks()

    turtle.penup(); turtle.home()
    turtle.goto( 0, 100 ); turtle.write( "H A M C A L C", align="center", font=("Helvetica", 24, "normal") )

    # Create an empty undo buffer to simplify undrawing the hands.
    turtle.setundobuffer( 128 )

def hand( angle_sec, radius, width ):
    """Draw one hand at the given angle, radius and width.

    :param angle_sec: Angle, measured in seconds 0..60.
    :param radius: Length of hand.
    :param width: Width of stroke.
    """
    turtle.penup(); turtle.home()
    turtle.pendown()
    turtle.setheading( 90-angle_sec*6 )
    turtle.pensize( width )
    turtle.forward( radius )

running=True

def hands( freq=166 ):
    """Draw three hands.

    :param freq: Frequency of refresh in milliseconds.
    """
    global running
    now= datetime.datetime.now()
    time= now.time()
    h, m, s, ms = time.hour, time.minute, time.second, int(time.microsecond/1000)

    # Erase old hands.
    while turtle.undobufferentries():
        turtle.undo()

    # Draw new hands.
    hand( h*5+m/60+s/3600, .6*R, 3 )
    hand( m+s/60, .8*R, 2 )
    hand( s+ms/1000, .9*R, 1 )

    # Draw date and time
    turtle.penup(); turtle.home()
    turtle.goto( 0, -120 ); turtle.write( now.strftime("%b %d %H:%M:%S"), align="center", font=("Helvetica", 24, "normal") )

    # Reschedule hands function
    if running:
        # Reset timer for next second (including microsecond tweak)
        turtle.ontimer( hands, freq-(ms%freq) )

def stop(x,y):
    print( "Stopping" )
    running= False
    turtle.bye()

#turtle.speed("fastest") # Doesn't much matter
turtle.hideturtle()
turtle.tracer(False) # Essential in order to eliminate animation.
face(tick_circles)

turtle.onclick(stop)
now= datetime.datetime.now()
wait= 1000-(now.time().microsecond//1000)
turtle.ontimer( hands, wait )
print( "Initial wait", wait, "ms after", now.strftime("%H:%M:%S" ) )
turtle.mainloop()

