# 3η εργασία Αρχιτεκτονικής Προηγμένων Υπολογιστών
## Συντελεστές (ομάδα 9):
Κυδώνης Ιωάννης, ΑΕΜ: 9407, email: ikydonis@ece.auth.gr  
Ούρδας Αντώνιος, ΑΕΜ: 9358, email: ourdasav@ece.auth.gr

## Βήμα 1

### Ερώτημα 1

Η ισχύς που καταναλώνεται από ένα ολοκληρωμένο κύκλωμα μπορεί να είναι είτε στατική (static ή leakage) είτε δυναμική (dynamic).

Στατική ισχύς (leakage power) είναι εκείνη που καταναλώνεται από τα transistor για να βρίσκονται σε λειτουργία και οφείλεται κυρίως σε διαρροές ρεύματος υποκατωφλίου οπότε παραμένει σχετικά σταθερό<sup>[[1]](#πηγές)</sup>.

Δυναμική ισχύς (dynamic power) είναι αυτή που καταναλώνεται κατά την αλλαγή κατάστασης του transistor.
Όσο δε συμβαίνουν μεταβολές στην κατάσταση των transistors η δυναμική ισχύς που καταναλώνεται είναι μηδενική<sup>[[2]](#πηγές)</sup>.

Τρέχοντας λοιπόν ένα διαφορετικό πρόγραμμα η δυναμική ισχύς (dynamic) μπορεί να είναι διαφορετική, υψηλότερη στην περίπτωση που προκύπτουν περισσότερες εναλλαγές κατάστασης στα transistor του επεξεργαστή και χαμηλότερη αν προκύπτουν λιγότερα. Ένα πιο "βαρύ" πρόγραμμα θα οδηγήσει και σε μεγαλύτερη δυναμική ισχύ.
Αντίθετα, η στατική ισχύς (leakage) θα παραμείνει σταθερή καθώς δεν εξαρτάται από τον αριθμό των εναλλαγών κατάστασης.

Αν θεωρήσουμε ότι το εκτελούμενο πρόγραμμα επιβαρύνει με σταθερό τρόπο τον επεξεργαστή, ο χρόνος εκτέλεσης του προγράμματος δεν παίζει ρόλο καθώς η ισχύς μας δίνει το έργο στη μονάδα του χρόνου.
Αν από την άλλη το εκτελούμενο πρόγραμμα δεν έχει ομοιόμορφη συμπεριφορά στον χρόνο τότε η μέση δυναμική ισχύς που θα προκύψει θα είναι διαφορετική καθώς ο αριθμός των εναλλαγών καταστάσεων στα transistor στη μονάδα του χρόνου δε θα είναι σταθερός.

### Ερώτημα 2

Για να συγκρίνουμε 2 επεξεργαστές ως προς την κατανάλωση ενέργειας που απαιτούν, χρειάζεται να λάβουμε υπόψιν όχι μόνο της ισχύ τους αλλά και το πόσο γρήγορα εκτελούν τις επιθυμητές εντολές.
Η σύγκριση λοιπόν πρέπει να γίνει με βάση την μετρική που δίνει το πηλίκο αριθμού εντολών ανά μονάδα έργου:
```
Efficiency = Instructions / Work

ή

Efficiency = (Instructions / Time) / (Work / Time)

ή

Efficiency = (Instructions / Time) / Power

ή

Efficiency = Instructions / (Time * Power)
```

οπότε για τη συγκεκριμένη περίπτωση όπου Power<sub>1</sub> = 4 W και Power<sub>2</sub> = 40 W έχουμε:

<pre>
Efficiency<sub>1</sub> < Efficiency<sub>2</sub>

ή 

Instructions / (Time<sub>1</sub> * Power<sub>1</sub>) < Instructions / (Time<sub>2</sub> * Power<sub>2</sub>)

ή

Time<sub>1</sub> * Power<sub>1</sub> > Time<sub>2</sub> * Power<sub>2</sub>

ή

Time<sub>2</sub> < Time<sub>1</sub> / 10
</pre>

Αν λοιπόν ο επεξεργαστής με ισχύ 40 W εκτελεί τον επιθυμητό αριθμό εντολών σε χρόνο μικρότερο από το ένα δέκατο του χρόνου που χρειάζεται ο επεξεργαστής των 4 W τότε μπορεί να προσφέρει στο σύστημα μεγαλύτερη διάρκεια μπαταρίας.

### Ερώτημα 3

Εάν η λειτουργία του συστήματος δεν τερματιστεί τότε ακόμα και αν ο επεξεργαστής βρίσκεται σε idle κατάσταση θα καταναλώνει ενέργεια που προσδιορίζεται από τη στατική ισχύ (leakage).

Τα αποτελέσματα που προκύπτουν από την εκτέλεση του McPAT για τον Xeon είναι:
```
Processor: 
  Area = 410.507 mm^2
  Peak Power = 134.938 W
  Total Leakage = 36.8319 W
  Peak Dynamic = 98.1063 W
  Subthreshold Leakage = 35.1632 W
  Subthreshold Leakage with power gating = 16.3977 W
  Gate Leakage = 1.66871 W
  Runtime Dynamic = 72.9199 W
```

και για τον ARM A9 2GHz:
```
Processor: 
  Area = 5.39698 mm^2
  Peak Power = 1.74189 W
  Total Leakage = 0.108687 W
  Peak Dynamic = 1.6332 W
  Subthreshold Leakage = 0.0523094 W
  Gate Leakage = 0.0563774 W
  Runtime Dynamic = 2.96053 W
```

Οπότε θεωρώντας ως χρόνο εκτέλεσης Time<sub>1</sub> τον χρόνο εκτέλεσης του προγράμματος στον Xeon και Time<sub>2</sub> = 40 * Time<sub>1</sub> τον χρόνο εκτέλεσης στον ARM A9 2GHz έχουμε:
<pre>
Energy<sub>1</sub> < Energy<sub>2</sub>

ή

Time<sub>1</sub> * ((Peak Dynamic)<sub>1</sub> + (Total Leakage)<sub>1</sub>) + (Time<sub>2</sub> - Time<sub>1</sub>) * (Total Leakage)<sub>1</sub> < Time<sub>2</sub> * (Peak Dynamic)<sub>2</sub>

ή

(Peak Dynamic)<sub>1</sub> + (39 / 40) * (Total Leakage)<sub>1</sub> < 40 * (Peak Dynamic)<sub>2</sub>

ή

98.1063 + (39 / 40) * 36.8319 < 40 * 1.6332
(αδύνατο)
</pre>

Παρατηρούμε ότι δεν είναι εφικτό ο Xeon να γίνει πιο energy efficient από τον ARM A9 2GHz κυρίως λόγω της στατικής ισχύος εάν υποθέσουμε ότι τα 2 συστήματα λειτουργούν για τον ίδιο χρόνο.

## Βήμα 2

### Ερώτημα 1

## Πηγές
[1] [semiengineering.com - Power Consumption: Components of power consumption](https://semiengineering.com/knowledge_centers/low-power/low-power-design/power-consumption/)  
[2] Tarek Darwish, Magdy Bayoumi - The Electrical Engineering Handbook (2005), pp 270-271
