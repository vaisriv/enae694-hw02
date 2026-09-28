/////////////
// Imports //
/////////////
#import "@preview/adaptable-pset:0.2.0": *
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.8.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages)

/////////////////
// Maths Setup //
/////////////////

// upright vectors
#let vectorboldupright(a) = vb($upright(#a)$)
#let vbu = vectorboldupright
#let vectorunitupright(a) = vu($upright(#a)$)
#let vuu = vectorunitupright
#let vectorarrowupright(a) = va($upright(#a)$)
#let vau = vectorarrowupright

// automatically use square brackets for vectors and matricies
#set math.vec(delim: "[")
#set math.mat(delim: "[")
#let vecrowOld = vecrow
#let vecrow = vecrowOld.with(delim: "[")

// custom units
#add-unit("decibelIsotropic", "dBi", "upright(\"dBi\")", space: true)
#add-unit("decibelWatt", "dBW", "upright(\"dBW\")", space: true)

////////////////////
// Document Setup //
////////////////////

// assignment info
#show: homework.with(
    title: "HW02 - Received Power and Link Geometry",
    author: "Vai Srivastava",
    collaborators: [],
    course-id: "ENAE694: Spacecraft Communications",
    instructor: "Prof. David Israel",
    semester: "Fall 2026",
    due-time: "September 28th. at 17:00",

    // (defaults to A4)
    paper-size: "us-letter", 
)

// document settings
#set text(font: "New Computer Modern", size: 10pt)
#set enum(numbering: "a)")

// problem headings
#let probOld = prob
#let prob = prob.with(color: black)

////////////////////////////
// The Assignment Itself: //
// Problems and Solutions //
////////////////////////////

#prob(title: [Slant Range #emph[(20 pts.)]])[
    A spacecraft is in a circular orbit #qty(500, "km") above Earth. Calculate its slant range from a ground station when its elevation angle is #qty(10, "degree"). Use an Earth radius of #qty(6378, "km"), neglect station altitude, and round to the nearest kilometer. Set your calculator to degrees.
] <hwk:p01>

// TODO:
answer

<hwk:s01>

#pagebreak(weak: true)

#prob(title: [Voyager 2 Received Power #emph[(60 pts.)]])[
    Calculate total recieved signal power for Voyager 2' X-band link to DSS-43, the #qty(70, "m") antenna in Canberra. Use the updated range below with radio parameters from JPL's January 1st., 1996 budget @descanso-voyager[Table 5-3, p. 26].

    - Range: #qty(21476670660, "km")
    - Frequency: #qty(8.415, "GHz")
    - Transmit Power: #qty(12.3, "W")
    - Transmit Antenna Gain: #qty(48.20, "dBi")
    - Recieve Antenna Gain: #qty(74.01, "dBi")

    Use #qty(0, "dB") transmit feed loss and #qty(0.42, "dB") other losses (pointing, atmosphere, and polarization combined).

    1. Calculate [EIRP] in #unit("dBW"). #emph[(20 pts.)]
    <hwk:p02a>

    2. Calculate free-space path loss [$"L"_"p"$] in #unit("dB"). #emph[(20 pts.)]
    <hwk:p02b>

    3. Calculate recieved power [$"P"_"r"$] in #unit("dBW"). Round your results to one decimal place. #emph[(20 pts.)]
    <hwk:p02c>
] <hwk:p02>

// TODO:
answer

<hwk:s02>

#pagebreak(weak: true)

#prob(title: [The Elevation Mask Trade #emph[(20 pts.)]])[
    For the Earth-orbiting spacecraft in #link(<hwk:p01>)[Problem 1], suppose we increase the minimum elevation angle used for contacts. In two or three sentences, explain what happens to the maximum useful slant range, the worst-case free-space path loss, and the available contact time. Keep the orbit, station, frequency, and antenna gains unchanged.
] <hwk:p03>

// TODO:
answer

<hwk:s03>

#pagebreak(weak: true)

== Code

#codly(header: [./src/index.py])
#raw(read("../src/index.py"), block: true, lang: "python") <code:index.py>

#pagebreak(weak: true)

== References

=== Formulas

#set math.equation(numbering: "(1)")

$
    d = sqrt((R_E + h)^2 - R_E^2 cos^2(e) - R_E sin(E))
$

$
    [P] = 10 log_10 (P/(1 W))
$

$
    [E I R P] = [P_t] - [L_t] + [G_t]
$

$
    [L_p] = 92.45 + 20 log_10(R) + 20 log_10(f)
$

$
    [P_r] = [E I R P] - [L_p] + [G_r] - [L_"other"]
$

For slant range, $h$ is altitude and $e$ is elevation. In the path-loss formula, enter $R$ in #unit("km") and $f$ in #unit("GHz"). Brackets denote decibel values. Power is in #unit("dBW"), antenna gains are in #unit("dBi"), and losses are in #unit("dB"). Record losses as positive amounts and subtract them.

=== Bibliography

#bibliography("../references/literature.yaml", title: none) <ref:bibliography>
