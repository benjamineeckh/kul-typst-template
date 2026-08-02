#let submission-text(degree, elective) = (
  "en": [
    Thesis submitted for the degree of Master of Science in #degree, option #elective
  ],
  "nl" : [
    Thesis voorgedragen tot het behalen van de graad van Master of Science in de ingenieurswetenschappen: #degree, hoofdoptie #elective
  ]
)

#let copyright(authors-string) = (
  "tm": [
    #sym.copyright 2025 KU Leuven – Faculty of Engineering Science\
    Published by #authors-string,\
    Department of Computer Science, Celestijnenlaan 200A bus 2402, B-3001 Leuven
  ],
  "en" :[
    All rights reserved. No part of the publication may be reproduced in any form by print,
    photoprint, microfilm, electronic or any other means without written permission from the
    publisher. This publication contains the study work of a student in the context of the
    academic training and assessment. After this assessment no correction of the study work
    took place.
  ],
  "nl": [
    Alle rechten voorbehouden. Niets uit deze uitgave mag worden vermenigvuldigd en/of
    openbaar gemaakt worden door middel van druk, fotokopie, microfilm, elektronisch of op
    welke andere wijze ook zonder voorafgaande schriftelijke toestemming van de uitgever.
    Deze uitgave bevat het studiewerk van een student in het kader van de academische
    opleiding en examenbeoordeling. Na deze beoordeling vond geen correctie plaats van het
    studiewerk.
  ]
)
