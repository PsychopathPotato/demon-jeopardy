CREATE TABLE Category (
  cId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  cName TEXT NOT NULL
);

CREATE TABLE Timer (
  timeId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  time INTEGER NOT NULL
);

CREATE TABLE Point (
  pId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  timeId INTEGER NOT NULL,
  pAmount INTEGER NOT NULL,
  FOREIGN KEY (timeId) REFERENCES Timer(timeId)
);

CREATE TABLE Question (
  qId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  cId INTEGER NOT NULL,
  pId INTEGER NOT NULL,
  qText TEXT NOT NULL,
  FOREIGN KEY (cId) REFERENCES Category(cId),
  FOREIGN KEY (pId) REFERENCES Point(pId)
);

CREATE TABLE Answer (
  aId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  qId INTEGER NOT NULL,
  aText TEXT NOT NULL,
  FOREIGN KEY (qId) REFERENCES Question(qId)
);

CREATE TABLE Q_Table (
  tID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  cId INTEGER NOT NULL,
  qId INTEGER NOT NULL,
  attempted INTEGER DEFAULT 0,
  FOREIGN KEY (cId) REFERENCES Category(cId),
  FOREIGN KEY (qId) REFERENCES Question(qId)
);

CREATE TABLE Icon (
  iconId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  iconName TEXT NOT NULL
);

--CREATE TABLE Option (
--  oId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
--  sfx INTEGER DEFAULT 1,
--  volume INTEGER DEFAULT 1,
--  animations INTEGER DEFAULT 1
--);

CREATE TABLE Solo (
  sId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  tId INTEGER NOT NULL,
  iconId INTEGER NOT NULL,
--  oId INTEGER NOT NULL,
  sName TEXT NOT NULL,
  sPoints INTEGER DEFAULT 0,
  FOREIGN KEY (tId) REFERENCES Q_Table(tId),
  FOREIGN KEY (iconId) REFERENCES Icon(iconId)
--  FOREIGN KEY (oId) REFERENCES Option(oId)
);

CREATE TABLE Versus (
  vId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  tId INTEGER NOT NULL,
  iconId INTEGER NOT NULL,
--  oId INTEGER NOT NULL,
  vName TEXT NOT NULL,
  vPoints INTEGER DEFAULT 0,
  FOREIGN KEY (tId) REFERENCES Q_Table(tId),
  FOREIGN KEY (iconId) REFERENCES Icon(iconId)
--  FOREIGN KEY (oId) REFERENCES Option(oId)
);

CREATE TABLE Steal (
  stId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  vId INTEGER NOT NULL,
  qId INTEGER NOT NULL,
  timeId INTEGER NOT NULL,
  attempted INTEGER DEFAULT 0,
  FOREIGN KEY (vId) REFERENCES Versus(vId),
  FOREIGN KEY (qId) REFERENCES Question(qId),
  FOREIGN KEY (timeId) REFERENCES Timer(timeId)
);

CREATE TABLE Result (
  rId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  vId INTEGER NOT NULL,
  rRanking INTEGER NOT NULL,
  rName TEXT NOT NULL,
  rPoints INTEGER NOT NULL,
  FOREIGN KEY (vId) REFERENCES Versus(vId)
);

CREATE TABLE Scoreboard (
  sbId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  sId INTEGER DEFAULT NULL,
  rId INTEGER DEFAULT NULL,
  sbName TEXT NOT NULL,
  sbPoints INTEGER NOT NULL,
  FOREIGN KEY (sId) REFERENCES Solo(sId),
  FOREIGN KEY (rId) REFERENCES Result(rId)
);

INSERT INTO Category (cId, cName) VALUES 
(?, 'Abrahamic'), (?,'Norse'), (?, 'Goetia'), (?, 'Japanese'), (?, 'Greco-Roman'), (?, 'Hinduism');

INSERT INTO Timer (timeId, time) VALUES
(?, 120), (?, 150), (?, 180);

INSERT INTO Point (pId, timeId, pAmount) VALUES
(?, 3, 100), (?, 3, 250), (?, 2, 500), (?, 2, 750), (?, 1, 1000);

INSERT INTO Question (qId, cId, pId, qText) VALUES
-- Abrahamic
(?, 1, 1, 'The lowest of the nine orders of angels, last in the Third Sphere. They are the "watchers" who never sleep. Among these are the guardian angels who are assigned to every human at birth.'),
(?, 1, 1, 'The eighth class of angels, second rank in the Third Sphere, they are directly involved in the world of humans as the bearers of the will of God, acting as a bridge between humans and their Lord. At the end of the world, they will be charged with blowing the Seven Horns. They have a spiritual awareness two levels higher than humans. Unlike angels, their role is to guide groups and nations rather than individuals.'),
(?, 1, 1, 'The seventh of the nine orders of angels and first of the Third Sphere. They are the guardians of cities and nations, as well as the protectors of various religions.'),
(?, 1, 1, 'The sixth of the nine orders of angels and ranked third in the Second Sphere. Their name means "power of God" and they are called the angels of victory. They patrol corridors of Heaven to ward off invasion by demons. They are the frontline soldiers of the holy army, which puts them most at risk of being tainted. It is thus said that many of the fallen angels once held this rank.'),
(?, 1, 1, 'The fifth class of angels, ranked second among the Second Sphere. Their name signifies the virtue of God.
They lack physical bodies and cannot directly affect reality. They are known as "the shining ones" and "the luminous ones." They manifest themselves in the form of miracles and create them before all who strive toward noble goals or fight in the name of good, bestowing favor and courage upon them.
It is said that two of these angels of might were summoned to accompany Christ during his Ascension. They also acted as midwives for the birth of Cain, the first child of Adam and Eve.'),
(?, 1, 1, 'The fourth class of angels, ranked first among the Second Sphere. Their name signifies control and rule.
They are seen as symbols of mercy and are charged with effecting rule of God over the entire earth. They also serve to convey the will of God to lesser angels and see that it is carried out. They are said to receive orders from the angels of wisdom, and faithfully obey them.
The scepters that they always hold in their hands are held to be a symbol representing power of God. In addition to these scepters, they are also sometimes depicted as holding scriptures, swords, or scales.
The Second Sphere of angels was created by God to serve as the link between the order of the universe and the world of the angels. Their presence and importance are believed to be much lower than that of other angels.'),
(?, 1, 1, 'They are the third highest rank of angels. They are the angels of dignity and justice who carry the throne of God and govern thought. They are given the task of deciding how to dispense decisions of the Lord. They have a pair of green burning wheels and are said to be chariot of God.'),
(?, 1, 1, 'The second highest rank in the angelic hierarchy.
They are represented by four wings and four faces, and carry the throne of God or drive His chariot. In the Bible, they are known as the gatekeepers of the Garden of Eden, where they are said to guard the tree of life with flaming swords.'),
(?, 1, 2, 'The highest rank of all angels, it is the being closest to God.
Humans can rarely detect their presence, but they are said to have four heads and six wings. They also appear in human form.'),
(?, 1, 2, 'One of the four major archangels. She is also the only female angel at this rank. Her name comes from the Sumerian word for "governor".'),
(?, 1, 2, 'One of the four major archangels. His name means "healer". He explains the history of the fallen angels and the creation of Adam and Eve.'),
(?, 1, 2, 'One of the four major archangels.
His name means "Flame of God," and he possesses knowledge of all celestial phenomena. He is also the first angel Satan met after falling to Earth.'),
(?, 1, 3, 'One of the four major angels. His name means, "He who is like god". He stands at the top of the angel hierarchy. He carries an unusually long sword that can cut through anything.'),
(?, 1, 4, 'The king of the abyss that appears in the Revelations of the New Testament. He controls locusts and plagues.
He leads the seventh order of demons who appear at the sounding of the fifth trumpet on Judgement Day, when he will bring a horde of locusts to make people suffer. His name in Hebrew means "destroyer" and "endless pit." It is thought that his origins lie in deification of the natural disasters caused by locust swarms.'),
(?, 1, 5, 'A fallen angel and the lord of Hell and all its demons in Judeo-Christian lore.
He was once the highest-ranking Seraph, second to God, whose name means "Light-Bringer." His pride led him to revolt, taking a third of the heavenly host with him. He now awaits a second chance to challenge God.'),
(?, 1, 4, 'The prince of darkness in Judeo-Christian lore, whose name means "adversary". He stands below God, the Judge, and was sent by Him to test the piety of Man. He also tempted Jesus during his 40 days in the desert.'),
(?, 1, 4, 'The "Lord of the Flies" and the prince of evil, he is right-hand man of Satan. He uses flies to carry souls of the dead. It is said that he is a derivation of the Canannite god, Baal.'),
(?, 1, 5, 'The greatest and most mysterious of the angels. He has many names, such as the Voice of God and the Angel of Contracts.
His name is said to originate from the "one who serves behind the throne," and he acts as a representative of God. He has immense power, and his body is the largest amongst the angels. In contrast to his duty to maintain the world, he is said to have a merciless side and has slaughtered hundreds of humans who disobeyed him.'),
(?, 1, 5, 'Angel of heavenly hymns. His name means "brother" and is the twin of Metatron. He is a giant whose head reaches heaven and a man could spend a life time trying to climb him but never reach the top. He is also responsible for deciding the gender of a child in the womb and there are even theories of him actually being a woman.'),
(?, 1, 2, 'One of the Four Horsemen of the Apocalypse spoken of in the Book of Revelation.
He rides a white horse and carries a bow. He wears a resplendent crown as a symbol of the dominion God has over Armageddon, and promises to bring total victory.'),
(?, 1, 2, 'One of the Four Horsemen of the Apocalypse spoken of in the Book of Revelation. He rides a red horse and carries a great sword. He has the power to destroy peace and make men slay one another.'),
(?, 1, 3, 'One of the Four Horsemen of the Apocalypse spoken of in the Book of Revelation. He rides on a black horse and holds a scale in his hands. He causes famine, starving people to death, but leaves the luxuries intact.'),
(?, 1, 3, 'One of the Four Horsemen of the Apocalypse spoken of in the Book of Revelation.
He rides upon a sickly pale horse and bears the name "Death." The embodiment of Hell itself follows behind him, eager to claim his victims. Fittingly, he has been given authority to mete out widespread death and disease.'),
(?, 1, 4, 'Angels that are said to be the ones to sound the trumpets at the time of the apocalypse. As each trumpet sounds, more and more plagues and disasters will occur, turning the earth into a land of death and suffering.'),
(?, 1, 5, 'The "Mother of Whores" mentioned in the Book of Revelation.
She is depicted riding an unholy crimson beast with seven heads and ten horns, while holding a golden cup of filth in her hand.
The "Mother of Babylon" is described in chapter 17 of Revelation. The heads and horns of the beast represent "kings", and the woman herself is "the great city which reigns over the kings of the earth." This imagery has been interpreted as an allegory of the Roman Empire.'),
(?, 1, 3, 'A Canaanite god of fire.
Tradition states that a bronze statue of a human with the head of a female ox would be placed at the altar as its vessel. It is said that the statue would first be heated with fire, then children would be put inside as a sacrifice. The Bible mentions its name as a cruel pagan god.'),
(?, 1, 3, 'The Canaanite god of death. Every year he attempts to kill Baal, the god of fertility, only to see him raised from the dead with the help of sister of Baal, Anat.'),
(?, 1, 4, 'A mysterious angel with the name "Poison of God." He is often depicted as a serpent. There are some theories that he is a fallen angel, but some say he is still an angel. Either way, he is associated with death.'),
(?, 1, 4, 'An angel in Judeo-Christian lore that presides over conception.
She is the intermediary between pregnant women and God. When a woman conceives a child, the seed is given to God, who then decides the sex, appearance, and destiny of the child. After such things are decided, a new soul is placed into the womb.'),
(?, 1, 4, 'Said to have been first wife of Adam. Refusing to obey him, she left Eden and became a demon of the night.
Though there are several theories regarding her disobedience, she is often regarded as a symbol of infidelity. Some theories suggest she was originally the mother goddess of Babylonia. In the Zohar, a Jewish spiritual text, she is listed as the first of four female demons; seducer of men, killer of infants, and first consort of Samael.'),
(?, 1, 2, 'A demon in female form from Judeo-Christian lore. Said to tempt sleeping men and attack infants.
She is the daughter of the demoness Lilith who tempted Adam. Like her mother, she drains men of their essence.'),
(?, 1, 5, 'An angel who persecutes evil in Hebrew lore. His role is to deliver punishment on behalf of God.
He is said to be permitted by God to tempt humans and test their faith, and even has demons as his servants, at the behest of God. The Zadokite Fragments and the Dead Sea Scrolls describe him as the angel of woe, the father of all evil, and a flatterer of God.'),

--Norse
(?, 2, 5, 'Figures in Norse mythology considered to be spiritual companions of humans.
While they are said to be protectors of agriculture and livestock, they are also noted as masters of war. They are sometimes regarded as spirits that accompany the Valkyrie, or play a similar role. Also interpreted as lesser goddesses.'),
(?, 2, 2, 'Small earth spirits of Norse mythology. They tend to be greedy and skeptical, and have excellent forging skills. They are known for creating a number of weapons and magical items. They may be small, but they also have great strength.'),
(?, 2, 2, 'A type of fairy that lives underground in the hills and fields where nature remains unspoiled. They are thought to have originated in Scotland, but appear in folklore throughout western and northern Europe. Both males and females appear young and beautiful, and enjoy eternal life. It is said that if a human sees one, he or she will fall in love at first sight.
They have a hollow in their backs and a long tail of a cow. They are a gentle folk who love music and sometimes dance on the hilltops. However, some they live in human houses and cause mischief. They are said to have their own kingdom and a society much like ours.'),
(?, 2, 4, 'An evil dragon defeated by the hero Seigfried. It is said that dwarven sorcerers transformed into a dragon to hold the gold of Rhein. It is also said that one who bathes in its blood can understand birds and repel steel. When Seigfried bathed in his blood, some leaves had stuck to his shoulders. These were the only areas the blood of the dragon did not touch, leaving him vulnerable.'),
(?, 2, 4, 'A monstrous wolf of Norse mythology. Son of the evil god Loki, he is said to swallow the god Odin at the worlds end.
He is bound with the magic rope Gleipnir, but it is said that he will be released from this bondage on the apocalyptic day of Ragnarok and stand against the gods.'),
(?, 2, 3, 'One of the most beautiful gods of Norse lore, he is also known as the White God.
He guards the Bifrost Bridge, the entrance to Asgard, kingdom of the gods. He will blow his Gjallarhorn to signal the beginning of the end of all nine worlds. He and Loki are mortal enemies, and are fated to kill one another during Ragnarok.'),
(?, 2, 4, 'The goddess of the underworld in Norse mythology. She lives in a hall called Eljudnir. Her father is the demon god Loki, and her mother is the giantess Angrboda. Her brothers are the giant wolf Fenrir and the world serpent Jormungandr. Together, these three are known as the "Calamitous Three." When Loki tricked Hodr into killing the god of light Baldur with a spear of mistletoe, she set an impossible task as a condition for restoring him to life. The world was thus robbed of light, signaling the beginning of Ragnarok.
She rules over Niflheim, the realm of the dead, where she controls the fate of all dead souls in the world.
Half of her body is black and rotted, a symbol of her lordship over the dead and her role in judging all life.'),
(?, 2, 5, 'A giant eagle that dwells in Yggdrasil. His name means "corpse swallower," and he devours the dead to carry their souls. He also flaps his wings to cause all the winds in the world. He is said to be descended from giants and can see the world from his high perch. He is the rival of Nidhoggr, and the two of them will fight even after Ragnarok.'),
(?, 2, 5, 'The blond-haired, blue-eyed trickster god of Norse mythology. He was born of the race of giants, but was accepted as one of the Aesir by Odin. He is strikingly handsome, but has a cunning streak that makes him a frequent nuisance to others. His murder of Baldur, son of Odin and the god of light, robbed the world of light and signaled the beginning of Ragnarok, the end times. With the giantess Angrboda he sired three children: the giant wolf Fenrir, the world serpent Jormangandr, and the goddess of the underworld Hel. At Ragnarok, he will lead the giants in their battle against the gods. There, he will fight the light god Heimdall, who had taken back the necklace Brisingamen after he stole it from the goddess Freya, and the two will slay each other.'),
(?, 2, 4, 'The god of light in Norse lore and son of Odin and Frigg. He is married to Nanna and has two brothers, Hod and Hermod, and a son named Forseti. He was loved by all the gods, but after having a nightmare of his death, Frigg made all the plants and animals swear not to harm him. Only the mistletoe was passed over as it was too young. Hearing this, Loki tricked Hod into shooting a mistletoe at him, which killed him. Hel promised to revive him if every living thing cried for him, but the giantess Thokk refused to weep. When it was found that Thokk was Loki in disguise, the gods punished him. With the light of the world gone, it took its first steps toward Ragnarok.'),
(?, 2, 2, 'An evil dragon that gnaws on the roots of Yggdrasil, the World Tree. It rules over the evil snakes that live there. Capable of surviving Ragnarok by feeding on the slain corpses that drift to it.'),
(?, 2, 3, 'Goddesses of fate in Norse lore. Said to be giantesses.
They live in a well below the roots of Yggdrasil, where they weave the threads of fate which bind even the gods.'),
(?, 2, 1, 'The chief god of Norse mythology. He is the god of war and death, skilled in magic and deeply associated with poetry and song. He is often depicted with long, white hair, missing one eye, and holding his spear Gungnir. It is said that none can match his prowess in magic, though he was once a pupil of the goddess Freya. Ever thirsty for knowledge, he will not hesitate to sacrifice to gain it. It is said he achieved wisdom by offering one of his eyes to the giant Mimi and drinking the Water of Knowledge from the roots of Yggdrasil. He lives in a great hall in Valaskjalf, home of the gods. From his throne Hlidskjalf he peers down at the world below. Whenever he sees brave warriors die in battle, he sends his warrior maidens, the Valkyries, to gather their souls and bring them to Valhalla, where they prepare for Ragnarok, the end of the world. At Ragnarok, he is fated to be swallowed by the giant beast Fenrir.'),
(?, 2, 4, 'A Norse giantess called the "snow-shoe goddess" and the embodiment of winter. According to legend, all the gods will return to her at the end of Ragnarok.'),
(?, 2, 5, 'An eight-legged horse of Norse lore that is the steed of Odin. Not only can it run at incredible speeds but it can also fly and ferry the dead to the heavens. Its father was Svaldifari and its mother was Loki in the guise of a female horse, given to Odin as a gift. It is also used as a symbol of the gallows. The tree from which Odin himself hug in the underworld to retrieve the Runes, was also called this.'),
(?, 2, 3, 'The ruler and guardian of Muspell. A black giant wielding.the flame sword Laevateinn, he will lead the flame giants into war during Ragnarok. He will survive Ragnarok, and cover the world with fire. This will be the destruction of the earth, before the world is reborn.'),
(?, 2, 1, 'The Aesir thunder god of Norse mythology. He rides a chariot pulled by two goats, and wields the hammer Mjolnir. He also wears the belt Megingjoro and iron gloves called Jarngreipr. He is the god of lightning and thunder, as well as fertility. At Ragnarok, he will defeat Jormundandr, but will succumb to its venom.'),
(?, 2, 2, 'Earth sprites of Norse legend. They originate from the race of giants in Norse mythology.
They are sometimes identified with dwarves as skilled blacksmiths. They are described as large, hideous, ill-mannered, and stupid. They are said to live in houses made of gold and crystal, and often venture out in the hills and fields in the whit nights of summer.'),
(?, 2, 1, 'Daughters of Odin in Norse lore. They ride their horses through the sky and fight.
Their duty is to guide the souls of warriors to Valhalla in preparation for Ragnarok. Their name means "chooser of the slain".'),
(?, 2, 5, 'A shining rooster in Norse lore that sits at the top of Yggdrasil, the World Tree.
Its name means "tree snake," and it releases light atop Yggdrasil. By basking in that light, Yggdrasil floats into the sky.'),
(?, 2, 5, 'The ash tree known as the World Tree in Norse lore.
Its branches cover the entire earth, and its trunk pierces the sky and holds up several worlds, including Alfheim, the abode of the Light Elves. Its three roots stretch into Jotunheim, Niflheim, and Asgard. It is said that it will live through Ragnarok.'),
(?, 2, 3, 'A goddess from Norse mythology. She is the keeper of the golden apples and wife to Bragi, the god of poetry.
Gods in Norse mythology are said to retain their youth via her apples, which are safely kept in a box made from ash wood.'),
(?, 2, 2, 'The name of the hero in the epic German poem, the Nibelungenlied, often seen as the same as Sigurd of Norse folklore.
He was married to Kriemhild, the princess of Burgundy, and is said to have become wrapped up in a feud between her and Brunhilde of Austrasia, resulting in many attempts on his life. The dragon, Fafnir, blood made him invincible, but a single leaf on his back resulted in a weak spot, which was later exploited by the treacherous Hagen.'),

--Goetia
(?, 3, 4, 'One of the 72 demons of the Ars Goetia. He is a Grand Duke that rules the eastern zone of Hell.
He rides various grotesque creatures, like crocodiles, and appears as an old sage with a hawk on his arm. He grants words of wisdom to those who summon him and will bring back fugitives who escaped the summoner. He also causes destruction through earthquakes.'),
(?, 3, 5, 'One of the 72 demons of the Ars Goetia.
He is the seventh spirit of Ars Goetia and the Grand Marquis of Hell. He is depicted in several different forms, sometimes appearing as a wolf with a serpent tail, and other times appearing as having the head of an owl, the torso of a wolf, and the tail of a snake sometimes replacing his hind legs altogether. It is said that he bestows knowledge of the past and the future. He is also incredibly loyal, having led his army to assist Satan when Satan rebelled against God.'),
(?, 3, 1, ' One of the 72 pillars of Solomon. A great marquis who leads an army of 30 demons. He appears astride a black wolf, with a great raven head and a sharp sword.
He possesses the power to bring about discord, and it is said that even a tightly-knit organization can be quickly torn apart.
He will also try to kill the summoner and everyone they are close to, so one must be careful not to show any openings.'),
(?, 3, 4, 'One of the 72 demons of the Ars Goetia, he was a cherub before his fall from grace.
He has three heads: a bull, a man, and a sheep. His legs are like that of a chicken, his tail is a venemous snake, and his wings are hideous. In his hands he holds a battle flag and a spear, and he rides a dragon, spitting flames from his mouth. If the conjurer approaches him with respect, he will obey and give rings, as well as teach astronomy and geometry. Later literature ties him to the sin of lust.'),
(?, 3, 3, 'One of the 72 demons of the Ars Goetia. A beautiful fallen angel said to be a duke of Hell.
He appears in the form of a prince riding a dragon and leads an army of 40 evil spirits. He can also travel through time. Originally he was the goddess Astarte in Phoenicia, but became warped into his current form by the Judeo-Christian God. In Christianity. he is a fallen Throne that lures men into leading indolent lives.'),
(?, 3, 4, 'A king of Hell, ruling over 66 demon legions. He is one of the 72 demons of the Ars Goetia and presides over all kinds of knowledge. It is said he is able to satisfy all sexual desires. He appears with a body of a spider and the heads of a cat, human, and toad. Though there are times at which he appears as a mix of these species. He is an especially powerful king in the Ars Goetia, and "leads the eastern army."'),
(?, 3, 5, 'The Earl of Duke of Hell that appears as a hunter. He is one of the 72 demons of the Ars Goetia, and used to be a Virtue.
He has several unique powers, such as finding treasure hidden by magicians and reconciling friends. He can also understand the cries of animals.'),
(?, 3, 3, 'One of the 72 demons invoked by King Solomon. He leads 50 legions of demons as their chief. He is said to appear before his conjurer as two beautiful angels in a chariot of fire. His name means "worthless," and he is known to be exceptionally cunning, having caused the fall of Sodom and Gommorah in addition to persecuting Jesus Christ.'),
(?, 3, 2, 'One of the 72 Spirits of Solomon, a duke who commanded an army of 26 demons. He is famous for his discontent, and litter, as well as for his duplicity. He appears as a soldier in crimson armor or ceremonial dress, astride a red horse.
It is said that many alchemists have summoned him for his knowledge of the past, future, and present, and his ability to turn any metal into gold.'),
(?, 3, 4, 'One of the 72 demons of the Ars Goetia. He lights candles on graves.
He only appears in human form when ordered to; at all other times he is a hideous monster. He has a great deal of knowledge and teaches about magic, herbs, and gems. It is said he also has the ability to control the souls of the dead.'),
(?, 3, 4, 'One of the 72 demons invoked by King Solomon. He is the Great President and Earl and commands many legions.
He appears before his summoner as a terrifying snake and grants knowledge of the past, present, and future. He can also transform into a human with a sword, large teeth, and two horns. Those who behold him are struck with terror.'),
(?, 3, 5, 'One of the 72 demons of the Ars Goetia.
He is a powerful Duke of Hell, with the ability to change his face into that of all men and women. In his hand is heavy book that only he can read, within which is written the past, present, and future thoughts of all living things.'),
(?, 3, 1, 'One of the 72 pillars of Solomon. He is the Great Marquis of Hell, number 69 in the hierarchy with 30 legions of evil spirits, and is the ruler of deception, rebellion, and surrender. He is summoned in the form of a pentagram. He is said to bring knowledge of the power hidden in plants and stones, and he also gives his summoners messengers in the form of birds.'),
(?, 3, 2, 'One of the 72 demons of the Ars Goetia. He appears as a knight holding a lance or pennon. The story goes that when he is called upon in battle, he will see through the enemy plans and predict the moves that are to come.'),
(?, 3, 1, 'One of the 72 Pillars of Solomon, he is the Grand Duke of Hell, number 64 in the hierarchy of command, who leads the 36 Legions. He is a very large and terrifying panther. He can take human form if the summoner wishes, but it is said that he has a terrifying expression on his face and flames flashing in his eyes.
He knows the truth about everything that has happened in the past, present, and future, and has the power to answer all questions, but he will always lie if he is not inside the magic circle. Other than that, he has the power to burn all of the enemies of its summoner.'),
(?, 3, 2, 'One of the 72 demons of the Ars Goetia. He was one of the Thrones who fell from grace. He appears as a silver sea monster, but can take the form of a human as well. He grants knowledge of various arts and sciences to his summoner. He can also change the hatred of ones enemies to something like friendship'),
(?, 3, 5, 'One of the 72 demons of the Ars Goetia, and the only female among them.
She is a beautiful woman with a golden crown and a pure white lace. She is said to have the power to see the past and future, knows how to gain the love of women, and sometimes turns into an ugly woman to test her summoners.'),
(?, 3, 4, 'One of the 72 demons of the Ars Goetia, sometimes referred to as Caacrinolaas.
His form is described as a dog with griffin-like wings, and he can impart instant knowledge in all arts and sciences. It is also said that he is the author of bloodshed and murder, excels at predicting the future, and can make people invisible. Some accounts suggest the demon Nebiros uses him as a mount.'),
(?, 3, 3, 'One of the 72 demons of the Ars Goetia.
He is called the Count of death and destruction, and appears as a jet-black dove with blood-red eyes. He is a craftsman and builds towers full of weapons.'),
(?, 3, 4, 'One of the 72 demons of the Ars Goetia. He appears as a man with a head of a bull.
He has knowledge of magical gems and plants, and teaches astronomy and astrology. He also sometimes gives his summoner a familiar.'),
(?, 3, 4, 'One of the 72 demons of the Ars Goetia, he is called the Great Duke of Thrones.
He appears clad in green armor, riding a gryphon, and wearing a crown symbolizing his station. Philosophy and necromancy are his forte, and he can use any corpse as a vengeful spirit. He also leads over 30 armies as a Grand Duke of Hell.'),
(?, 3, 4, 'One of the 72 demons of the Ars Goetia
He rides a horse and has the head of a lion and the tail of a snake, with the vipers held in both hands as well. He is knowledgeable in astrology, can transform a man into any form, has the power to turn a foe into a friend, and can give people new titles.'),
(?, 3, 1, 'One of the 72 Pillars of Solomon, he is the leader of a legion of 20 demons. He appears in the form of a horse, but can also assume human form.
He can see into the past, present, and future, and will answer truthfully to questions about creation and theology. He is also said to grant power and high-ranking priest status to his summoners. They are said to be faithful to the summoner, which is rare among demons, and will prevent attacks from other beings.'),
(?, 3, 2, 'One of the 72 Pillars of Solomon, he is the 57th president of Hell who leads 30 legions. He takes the form of a panther, but if the summoner wishes, he can assume the form of a human being with a fearless face.
He excels in theology and liberal arts, and can teach them to the summoner. He is also able to send any impression he wishes to any subject. If he deems the summoner worthy of summoning him, he will grant them the greatest blessings; if not, they will be devoured.'),
(?, 3, 5, 'One of the 72 demons of the Ars Goetia, he is called the "King of Dominions", and is depicted as a man with a face of a woman, wearing a crown of jewels and riding a camel with a single hump. He is knowledgeable in the sciences, arts, and secrets, and can share that information in an instant, causing those who have gained his help to no longer put forth effort.'),
(?, 3, 5, 'One of the 72 demons of Ars Goetia, said to be a beautiful blonde man with an ice-cold stare who rides on a winged horse. He can find or steal anything from anywhere in the world in an instant.'),
(?, 3, 5, 'One of 72 demons of the Ars Goetia. He is the great marquis of hell and controls 30 legions of demons. He appears as a stork with a raspy voice and is a liar, but will speak the truth when in a magic triangle. He can take away the use of a persons eyes, ears or mouth, and is adept at finding hidden treasure, likely because he is fond of stealing valuables to take back to hell.'),
(?, 3, 5, 'A prince of hell who is one of the 72 demons of King Solomon. He sometimes takes on the form of a man.
His appearance is somewhat uncertain; he may be a thrush, a raven, an owl, or something else, but it is agreed that he has the form of a bird. It is said his claws are silver and the areas around his eyes are red.
His strong points are astrology, the magical uses of gemstones, and plants such as medicinal herbs, and it is said if one summons him and asks a question, he will speak truthfully.'),

--Japanese
(?, 4, 4, 'A Japanese yokai said to have appeared in the Higo Province during the Edo period. One day, it was spotted as a glowing object in the sea, and made a prophecy to those who investigated it. The prophecy was that for the next six years, there would be a bountiful harvest, but also an epidemic of disease. Once that time came, it said, those who fell ill should be shown a drawing of her as soon as possible to ward off the sickness. Similar rumors were recorded around this time for amabiko, jinjahime, and kudan.'),
(?, 4, 5, 'An evil demon that can read minds of people. Also known as Ama no Sakugami, it reads minds and then says/does the opposite. It is also said to eat humans from the inside, then becoming them by wearing their skin.'),
(?, 4, 4, 'The Japanese goddess of light. She is a leading deity of Takamagahara, the land of the Amatsu gods.
She is said to have been born of left eye of Izanagi, and is enshrined in many places, such as Ise Grand Shrine. Her most well-known tale is when she grew so angry at her brothers, Susano-o-No-Mikoto, violence and chaos that she withdrew into Amano-no-Iwato, shrouding the world in darkness.'),
(?, 4, 2, 'A goddess of entertainment, her name means "the terrifying female of heaven."  She famously danced to lure an angry Amaterasu out from hiding in the Ama-no-Iwato cave. She also danced before the unexpected guest Sarutahiko in the Tenson Korurin and later became his wife.'),
(?, 4, 3, 'One of the chief gods of ancient Japanese lore. His image is reflected is shakoukidogu statues.
Because he was worshipped by Nagasunehiko, who defeated the army of Emperor Jimmu, he was seen as a symbol of rebellion toward the Emperor, causing his adherents to be persecuted.'),
(?, 4, 2, '"Fox" in the Ainu language. Though "Sumari" is another word for "fox," this name also refers to "those who we kill," and is said to be the general word for small-to-medium-sized animals.
In Ainu culture, it is also a divine beast that alerts people to forthcoming disasters by howling loudly from the mountains.'),
(?, 4, 1, 'The Nihonshoki deity of swords. He pacified Ashihara no Nakatsukuni before Ninigi descended there.
His name comes from "futsu," the fashion in which things are cut, and "nushi," his nature as a god.'),
(?, 4, 1, 'One of the four oni controlled by Fujiwara no Chikata, it sends hurricanes to blow away its enemies. Some say that it is the original ninja.'),
(?, 4, 5, 'A giant skeleton monster formed from the souls of humans who died in battle or of hunger.
It walks around at night, making clattering noises. If it spots a human, it will attack.'),
(?, 4, 5, 'A Japanese Shinto-Buddhist syncretism and guardian deity of Gion Shoja. He is also called Muto Tenjin. In ancient China, he was said to be the son of Xi Wangmu and had a castle in northern Tenjiku with 80,000 subordinate deities. In Onmyodo, he is considered to be the god Tendo-Jin. Though many theories about his true identity exist, the Gion Goengi claims he is Yakushi Nyorai (Buddha) of the Pure Land. Many worship him to ward off pestilence.'),
(?, 4, 3, 'Known in Japanese as "Inaba no Shirousagi," it is a smart rabbit written about in the Kojiki, worshiped as a hare god.
Wanting to cross the sea from Oki Island to the mainland, he had sharks line up in a row and crossed on them, under the guise of helping to count them. Once he crossed and revealed that he was just using them as a bridge, the sharks skinned him. He was healed by a passing god.'),
(?, 4, 5, 'The final child born to Izanagi and Izanami. Because he was on fire from the moment of his birth, he burned Izanami to death. Infuriated, Izanagi struck him down with his sword, Totsuka no Tsurugi. Many gods were born from the blood that then spurted from him. Many others, such as Take-Mikazuchi, were born from his corpse.'),
(?, 4, 4, 'A god who migrated from Silla to Kyushu to give oracles to the people.The guardian god of the samurai. Of all of the many gods of Japan, he is the most revered. According to the history of the Usa Shrine, Emperor Ojin is him. But it is also said that he is a legacy of Taoism, Buddhism and other mainland cultures, which shrouds his origin in mystery. Since he was the guardian god of the Genji clan, he has been worshipped by samurai since the Kamakura era.'),
(?, 4, 5, 'Japanese god of words, thought to be the deification of echoes.
In the Kojiki, the group of Emperor Yuraku supposedly encountered him at Mt. Katsuragi. Said to proclaim good and bad in a single word. All words uttered by him come true'),
(?, 4, 5, 'A spirit known as the god of wind, as well as the god of smithery.
His strong winds blow roofs and people away, and knock over ships in the sea. '),
(?, 4, 1, 'Spirits of dogs said to possess humans in Japanese folklore.
Those possessed enter a state of "inu-tsuki" and go crazy. Onmyoji, or Japanese sorcerers, summon them to do their will. It is often used as a curse to humiliate people, and it is said that this spirit is created by ending the life of a living dog in accordance with the art.'),
(?, 4, 1, 'A one-eyed, one-legged monster said to live deep in the mountains of Kumano, Japan, and believed to be the degraded blacksmith god, Ame no Me-Hitotsu no Kami.
A single footprint measuring 30 centimeters has been sighted in the snows of the mountain.'),
(?, 4, 3, 'With his spouse, this god created most of Japan and the human race. These acts of creations exacted a heavy price, and the goddess died in childbirth. When he sought to rescue her from Yomi, the hellish underworld, she begged him to wait in the darkness while she negotiated with its ruling powers. He tried, but his curiosity and thirst for the truth overwhelmed him. He lit a fire and saw the horrible sight of the rotting corpse of his once beloved. Shamed and betrayed, she flew into a rage and chased him from hell with an army of devils and monsters, but failed to kill him. She swore to have her vengeance on her husband by destroying one thousand of the lives he created every day. He vowed he would create fifteen hundred new lives every day, so that she could never end the world.'),
(?, 4, 3, 'Mother Earth goddess of Japanese mythology, she gave birth to the islands with her consort. She mothered many gods, but she died of burns birthing the fire god Hinokagutsuchi. Her husband traveled to Yomi no Kuni to bring her back to the land of the living, but because she ate the food of Yomi, she was no longer able to return. When her beloved lit a torch and saw her rotting body covered with maggots, he ran in fear. Afterwards, she became the goddess of the dead, Yomotsu-Okami'),
(?, 4, 3, 'A divine being who appeared from a glowing bamboo shoot. Though many proposed to her, none could complete her strict tasks, so she returned to her homeland, the capital of the moon.'),
(?, 4, 1, 'One of the four oni Chikata Fujiwara was said to have controlled during the Heian period of Japan. His body was so tough, swords and arrows bounced off of him.
It and its comrades fell into hell through holes that can still be found in Mie Prefecture, Japan (the modern-day Iga Province).'),
(?, 4, 4, 'A deity from Japanese mythology that governs fertility and fields. She was youngest of the eight daughters born to Ashinazuchi and Tenazuchi. All of her sisters were sacrificed to the giant snake Yamato-no-Orochi but when it was her turn, she was saved by Susano-o and became his wife.'),
(?, 4, 1, 'A wolf god of Japanese folklore. People originally feared the Makami, eventually that strong emotion deified the beast. The Makami can see into the heart of humans, protecting those who are good but punishing those who are evil. It is often drawn on prayer boards to prevent fires and thefts. At the same time, however, it was feared as a man-eater.'),
(?, 4, 4, 'A general who rebelled against the Imperial Court in the mid-Heian period.
He succeeded in ruling Kanto and declared himself emperor, but was later defeated by Fujiwara no Hidesato and Taira no Sadamori. After death, he was enshrined as a vengeful spirit, but was later viewed as a hero and became revered as a guardian deity of the Kanto region, where he has remained to this day.'),
(?, 4, 3, 'It was a native god worshipped in the Shinano region before the Yamato power took control.
Said to be a god born from the ancient belief that rocks and stones sheltered divine spirits.'),
(?, 4, 1, 'Long-lived cats are said to transform into these malevolent cat demons, and are distinguishable by their partially forked tails.
They can speak human languages, and their powers vary according to how long they lived, and how cruelly they were treated in life. Their abilities range from shape-shifting to controlling the dead.'),
(?, 4, 2, 'One of the four oni Chikata Fujiwara was said to have controlled during the Heian period of Japan. He had the power to disappear and make images of himself, leading people to believe that he is the originator of ninjits.'),
(?, 4, 1, 'An evil monster of Japanese lore known for its hideous visage and brute strength. They plunder and loot villages, massacring the townspeople with their iron clubs.
They have a horn on their heads, red skin, long claws, and razor-sharp teeth.'),
(?, 4, 1, 'One of the four oni controlled by Fujiwara no Chikata, it can cause floods with the swing of its arms.
In the Taiheiki, a brave courtier named Ki no Tomo-o expelled the oni by sending them an elegantly phrased threat in poetic form.'),
(?, 4, 4, 'A violent god of Japanese legend, he was one of three gods born from Izanagi.
Originally banned from Takamagahara for uncouth behavior, he later performed heroic deeds such as slaying Yamata-no-Orochi and became a great god of Ne-no-Kuni.'),
(?, 4, 2, 'A ghost of an old lady that is said to appear around Mt. Rokko who runs on all fours at blazing speeds. If you look at her back when she passes by you, you can see a piece of paper with the word "Turbo" posted on her. She is not a dangerous ghost, but simply one that runs around. Other similar ghosts include the "Dash Hag" of the Shuto Expressway and the "100 km/h Granny" of Hokkaido.'),
(?, 4, 5, 'The moon god from Japanese mythology. He was said to have been born from the right eye of Izanagi during purification after his escape Yomi no Kuni, the underworld. He was the second of the "three noble children", who was commanded by his father Izanagi to watch over the night sky. In the Chronicles of Japan, he and his sister, the sun goddess Amaterasu, part ways due to their disagreements. This is why the sun and moon appear at different times in the sky.'),
(?, 4, 2, 'A giant snake with eight heads and eight tails that appears in the Kojiki. Its body is like eight valleys and eight mountains, has moss, cedars and hinoki growing on it, and its stomach is red with blood.
It demanded a sacrificial maiden each year, but Susano-o got it drunk and killed it with his sword. The sword that came from inside its body was Ame-No-Murakumo, otherwise known as Kusanagi no Ken.'),
(?, 4, 4, 'A divine creature in Japanese mythology, they are three-legged ravens that the goddess Amaterasu sent to help humans.
It is said that they helped Emperor Jinmu claim victory, and, despite their divine standing, those who are unworthy have been known to go mad after looking them directly in the eye.'),
(?, 4, 5, '7 days after its birth, a wolf killed its mother. Yoshizane Satomi later promised the hand of his duaghter if it could defeat the enemy, but after his success, the retainer of Yoshizane shot it dead.'),
(?, 4, 2, 'A Japanese general of the Genpei War near the end of the Heian era and start of the Kamakura era.
Also known as Ushiwakamaru, he is said to have learned the art of war from the Mt. Kurama Tengu. On joining the army of his half-brother, Yoritomo, he defeated the Taira one by one, finishing them off at the battle of Dan-no-ura. Later, he was pursued by the army of Yoritomo and killed himself at Koromogawa.'),

--Greco-Roman
(?, 5, 4, 'The Greek goddess of hunting and chastity. She was often identified with the moon goddess Selene and was therefore also worshiped as a moon goddess herself.
Like her twin brother, Apollo, her association with archery granted her the title of "far-shooter" in addition to being recognized as a bringer of plague and death. This is depicted in myth, in which she is deceived by Apollo and shoots her beloved Orion.'),
(?, 5, 4, 'The brother of Prometheus and a strong hero. After the Titans lost the battle against Zeus and the other gods, he was punished. His sentence was to hold up the weight of heaven for all eternity. He was later turned to stone out of pity.'),
(?, 5, 2, 'One of the three Moirae Sisters in Greek mythology.
She cuts the life threads of those whose time has come.'),
(?, 5, 2, 'A Phrygian god who symbolizes life, death, and revival.
He rejected love of Cybele and was driven mad, dying shortly after castrating himself. Cybele resurrected him as a pine. He came to represent rebirth.'),
(?, 5, 1, 'A statesman, general, and author known for his rule over the Roman Republic. His many accomplishments led to his name being used as a title for later Roman emperors.'),
(?, 5, 5, 'A mysterious bird that can tell the severity of ones illness as well as heal sickness itself. One drew illnesses into itself with its beak and flew away, healing the sick. But if the sickness was too far advanced, the bird would refuse even to look at the sufferer. It is thought to be a plover or wagtail, but the only definite detail is that it is pure white.'),
(?, 5, 5, 'A sluggish creature that are believed to live by the Nile and have heavy heads, which keep their faces pointing downwards.
To compensate for their sluggishness, one look from their eyes can kill a person.'),
(?, 5, 1, 'A half-man, half-horse creature of Greek lore. The top half is human and the bottom half is a horse.
They are often depicted as wise and noble mentors of heroes. A common theory about their origins is that a non-riding culture saw men from another civilization mounted on horses and thought them to be half-horse.'),
(?, 5, 1, 'The guard dog of the gates of Tartarus. Its name means "demon of the pit." It is also known as the loyal servant of Hades, the king of the underworld. It has three heads and a tail of  a snake. It was born from Typhon, the giant of wind, and Echidna, the mother of monsters.'),
(?, 5, 5, 'The ferryman of Hades who carries the souls of the newly dead to the Greek Underworld, also known as Hades. For a fee, he would bring the dead across the River Acheron, or River Styx, that separated the world of the living from the world of the dead. Those who could not pay the fee were forced to wander the shores of the river as Wraiths for eternity'),
(?, 5, 1, 'A compound beast of many parts. It is the daughter of Echidna and Typhon, the god of the hot storm winds. She was originally a winged lion, but later the head of the goat and dragon were added. Her final depiction was a three-headed beast with the tail of a snake. The name It is now used as a catch-all term for synthetic beast'),
(?, 5, 2, 'One of the first primordial Deities created by Chaos in the Greek mythology, said to be the personification of time and eternity and the lord of the Zodiac. His name means the word "time".'),
(?, 5, 2, 'The youngest of the three Moirae Sisters of Greek legend. She spins the threads of life with her spindle.'),
(?, 5, 2, 'Phrygian goddess of the earth. She had a cult following even in Rome. A goddess of the mountains of Phrygia, she is often depicted on a throne with lions on each side or on a chariot pulled by lions and known as a mistress of animals. She was incorporated into Greek mythology as well, but was often seen as Rhea, who was another earth goddess, and eventually assimilated with her.'),
(?, 5, 5, 'A nymph of Greek lore who turned herself into a laurel to escape the pursuit of Apollo.
Affected by an arrow of Eros, Apollo chased her for days. When he had almost caught her, she prayed to Peneus, her father the river god, and was transformed into a laurel.'),
(?, 5, 4, 'A mother goddess in Roman lore, she is the goddess of hunting and the equivalent of Artemis.
She is often pictured with a deer at her side and is also known as the goddess of fertility. She is an eternal virgin and has her followers take a vow of virginity. Later Christian influence led her to be named the Queen of Witches.'),
(?, 5, 2, 'A goddess from Greek mythology. Her name means "Mother Earth" in ancient Greek.
She is the sister of Zeus, goddess of fertility, and is said to be the one who taught humanity the ways of agriculture. With the advancement of civilization, laws were put into place."'),
(?, 5, 1, 'The Greek god of wine and orgies. He had two births. When his mother died while pregnant with him, Zeus took the premature infant and let him mature to proper birth in his thigh.'),
(?, 5, 5, 'A monster from Greek mythology. Her upper half is a beautiful woman while her lower half is a spotted snake, and her name means "She-Viper". She gave birth to the most number of monstrous offspring in Greek mythology, including Cerberus, Orthrus, Hydra, Chimera and Ladon. She used her human half to lure unsuspecting travelers to her and devour them soon after. She was considered immortal according to some, but others also said that she was killed at the hands of the hundred-eyed giant, Argus.'),
(?, 5, 1, 'The Roman goddess of luck, she spins the Wheel of Fortune and is believed to have originally been a fertility goddess. Her Greek counterpart is Tyche.'),
(?, 5, 3, 'Mythical bird-creatures of Greek mythology, originating as goddesses of the island of Crete.
They are women from the waist up and birds from the waist down.They are forever driven by an insatiable hunger. Their faces are pallid and twisted into permanent snarls.They are timid and averse to conflict, yet spiteful and mischievous.
They are said to rule over a variety of domains, including death and storms.'),
(?, 5, 4, 'The goddess of the underworld in Greek lore. It is said she may be the deification of the strict personality of Queen Persephone.
Her duty sees the dead and those who incur the wrath of gods suffer by her extremely cruel hands. She is master of the Furies, goddesses of revenge. Her name means "she who acts from afar," and is associated with the moon. Later, when she was turned into a demon, she began to be depicted as having three heads: a dog, a lion, and a horse.'),
(?, 5, 3, 'Giants born from Uranus and Gaia in Greek mythology. The name means "those with a hundred arms."
During the war of the Titans, Zeus freed them from the underworld to help him obtain victory.'),
(?, 5, 1, 'A messenger god who served Zeus. His winged sandals allow him to fly, and he was worshiped as a god of travel and commerce. He was also known as a trickster, being able to freely cross between the mortal and godly realms.'),
(?, 5, 1, 'One of the monsters in Greek mythology. It is usually depicted as having nine heads, but some say that it has as many as 100.
Its father is Typhon, Giant of the Wind, and its mother is Echidna, Goddess of the Snake. It has incredible regenerative power; so much so that when one of its heads is cut off, two more will sprout from the wound. It is also extremely venomous, and simply inhaling its breath is enough to kill. The slaying of this beast is listed as one of the 12 great Labors of Hercules.'),
(?, 5, 4, 'The god of sleep, and the son of the goddess of night, Nyx. He appears as a beautiful young man. He dwells in the Underworld where light never reaches, sleeping on a soft bed surrounded by dreams.
He is a benevolent and kind person, bestowing dream to those who are tired. His abilities are so powerful that not even the mighty Zeus could resist.'),
(?, 5, 3, 'A priestess in service of the goddess Hera. When Zeus fell in love with her, he transformed her into a cow to hide her from Hera, but Hera saw through the ruse. She was rescued by Hermes, and escaped across the sea to safety.'),
(?, 5, 2, 'The middle sister of the three Moirae Sisters of Greek legend. She is the apportioner, measuring the thread which determines each lifespan of a person.'),
(?, 5, 1, 'A monster of Greek lore; one of the three Gorgon sisters.
She had snakes for hair, bronze scales for skin, golden wings on her back, sharp fangs, and eyes that could turn anyone who looked straight into them into stone. In some traditions, she was a beautiful woman, and her snake hair was her only ugly feature. With the help of the goddess Athena, Perseus was able to behead her.'),
(?, 5, 5, 'Considered the same as Hermes of Greek mythology. God of magic, literature, and medicine. Called psychopompus (guide of souls), he is said to escort the souls of the dead to the underworld. Because he was also the god of luck, he was believed to be the patron deity of merchants and robbers. In alchemy, he represents quicksilver, which served as an important catalyst because various metals can be dissolved in it.'),
(?, 5, 1, 'A fabled creature of Greek lore said to have the head of a bull and the body of a man.
Pasiphae was cursed to fall in love with a white bull. She lusted for it, and eventually gave birth to the part-bull part-human creature.
He was name was orginally Asterius. As he had the personality of a bull, he grew more and more violent. When he finally became uncontrollable, King Mino ordered Daedalus to build a giant maze, the Labyrinth, to keep it locked away. From there, he ate those who were sacrificed to him until his eventual death at the hands of Theseus.'),
(?, 5, 2, 'A sun deity who was worshiped in the Roman Empire from the 1st to the 4th century AD.
The rituals of the religion were secretive, but it is believed they entailed covering oneself in the blood of sheep and bulls. He was said to be reborn after death, inspiring worshipers to hold a festival each winter solstice.'),
(?, 5, 2, 'A young man of Greek lore. He rejected the nymph Echo, who faded to a whisper out of despair. Cursed by Nemesis, he fell in love with his own reflection and wasted away, becoming the flower that now bears his name.'),
(?, 5, 5, 'The goddess of victory, strength, speed and war in Greek mythology and the archetypal portrayal of the Abrahamic angels. As the deity of victory, her greatest feat was in the Titan War, in which she served as the personal charioteer of the gods. It is said that without her, the gods could not have won the war against the Titans.'),
(?, 5, 3, 'The goddess of the night in Greek mythology. She was born out of Chaos and gave birth to many offspring, including light (Aether), day (Hemera), death (Thanatos) and the Moirae Sisters'),
(?, 5, 1, 'A poet of Greek mythology skilled with the lyre. He tried to retrieve his wife, Eurydice, from Hades, but she vanished when he looked back before reaching the surface.'),
(?, 5, 2, 'A great two-headed dog in Greek mythology, with a mane and tail of snakes. He guarded the cattle of the monster Geryon, who lived on the island of Erytheia at the edge of the world. However, he was killed by a blow from the club of Heracles, who came to the island as part of his Twelve Labors.'),
(?, 5, 4, 'A dragon that signifies eternity. In biting its own tail, it forms a neverending circle.
In alchemy, the art of Hermes, it is considered an important material to create the Philosophers Stone. Some of its aspects are similar to those of Oceanus in Greek lore and the Biblical Leviathan.'),
(?, 5, 5, 'A god or goddess with a head of a donkey who was worshiped from northern Africa all the way to Rome. The donkey head has long been a sign of fertility and is often worshiped. His or her (there is some dispute amongst scholars) temple was built on Palatine Hill in Rome. The word "palace" came from the name of this god.'),
(?, 5, 2, 'The goddess who became the wife of Hades in Greek lore. She is said to have the power to bring fertility to the earth. While playing with the Oceanids, the earth cracked and Hades appeared to take her away to the underworld. Without her, the earth grew barren, but she was able to return for several months of each year, bringing stability back while she was free.'),
(?, 5, 3, 'A Titan of Greek lore. He was very intelligent; his name means "forethought."
He stole fire from Zeus and gave it to mankind. Zeus chained him to a rock as punishment and set an eagle to eat his liver every day. He was kept there until freed by Hercules.'),
(?, 5, 4, 'A gigantic, black snake god born from the Greek goddess Gaea with no father.
He has unparalleled prophetic abilities and has protected oracular shrines since days of old. Python is said to have been the guardian of Delphi, site of Delphic oracles. He is sometimes called "the king of the deceitful spirits" and gave prophecies that would only be in his favor, but he never gave prophecies that went against the will of Gaea.'),
(?, 5, 3, 'A fertility god of Roman mythology, associated with the primordial earth. He is commonly identified with the Greek god Cronus. Often referred to as "Black Sun" by Chaldean astronomers, linked to the low position of the sun around the time of the winter solstice. Also known as the "Night Sun" and also the "King of Death" living in the depths of the underworld. It is said that people prayed to him, the winter sun, to call for a new spring, and that custom became what we now know as Christmas.'),
(?, 5, 3, 'Greek god of death.
Son of Nyx, goddess of night. Priest of Hades, ruler of the underworld.
Cloaked in dark clothing, he wields a blade that brings death to its victims. Legend says he cuts the hair of those near death and sends the severed hair to the underworld, which pulls the victims down to their death.'),
(?, 5, 1, 'Reverend god of Greek lore.
He is the omniscient and omnipotent sky father, the king of the gods, head of the Twelve Olympians, and the ruler of the universe.
He is the son of Kronos, and the younger brother of Hades and Poseidon. He ruled the entire universe after defeating his father and the Titans.
He had many children with not only other goddesses, but also with humans.'),

--Hinduism
(?, 6, 4, 'One of the main Deva gods of Hindu lore. He is the embodiment of fire, said to have three heads and three or seven arms. Offerings to him are burned, and he carries them to the gods through the smoke.'),
(?, 6, 3, 'A giant elephant with four tusks which serves as the steed of Indra. His body is white as snow.
He was born from the churning of the milk ocean and is the king of elephants. His size is comparable to that of Mt. Kailash, where Shiva resides.'),
(?, 6, 1, 'One of the kings of the Nagas. It is a giant serpent with a thousand heads, whose name means "infinite." It sleeps under the earth and will watch over the end of the world with Vishnu. Until the time comes, he will protect Vishnu for eons in the sea of milk.'),
(?, 6, 1, 'Water spirits in Hindu lore. Their name means "those who move in the water."
They appear as young women with enchanting beauty often used as a symbol of temptation. They are known to carry the souls of those who die in battle to heaven, where Indra, the god of thunder, awaits them.'),
(?, 6, 3, 'A dual-gendered god whose appearance is the half that of the destroyer god Shiva and half his wife, Parvati. They are the ideal figure of Shaktism, the perfect god.'),
(?, 6, 2, 'A violent group of demons in Hindu lore. They were very powerful and caused the gods great trouble.
They are a strict group and attack anyone who runs counter to their ideals. They were originally gods of light who were worshipped in Persia. The Zoroastrian god Ahura Mazda was one of them.'),
(?, 6, 5, 'A Hindu ghost of a woman. She bewitches young men and possesses them.
A woman who dies in childbirth or during impure rituals becomes one of these. She has no mouth and her legs are on backwards. '),
(?, 6, 5, 'A type of preta, residing in the hunger realm of the six Buddhist domains. It cooks and eats insects out of the air with the fire it spits out, but its insatiable hunger is its eternal torment. They are small-wealth pretas, and are allowed to eat some unclean things; other preta are forced to eat feces or burnt bodies.'),
(?, 6, 1, 'An elephant-headed god of knowledge, learning, wealth, and prosperity in Hindu lore. He is the son of Shiva and Parvati.
Originally Parvati created him to stop anyone from watching her bathe. Shiva batted his head off but replaced it with a heaed of an elephant, resulting in his current from. Because he destroys obstacles and brings about good fortune and success, he is popular with merchants. He is also known as Vinayaka in Japanese Buddhism.'),
(?, 6, 4, 'Sacred incarnation of the Ganges River and is represented as a proud and beautiful woman. She was a river that flowed from the tip of the toe of Vinshu and passed through the heavenly lands, but it came to flow through the earth by the holy king Bagiratha. She comes from the Himalayas and the water pouring from her mouth is the source of the Ganges River. It is said that the water can cleanse all kinds of sins.'),
(?, 6, 2, 'A demon that takes the shape of a giant bird in Sri Lankan mythology.
It is believed to be a derivation of Garuda, the spirit bird of Indian mythology, which is in ideological opposition to its place in Sri Lankan mythology, in which it is interpreted as a demon.'),
(?, 6, 4, 'A holy white goose which serves as the steed of the Hindu god Brahma.
During winter, geese migrate over India. These majestic white figures flying through the sky became symbolic of Brahmin dignity as they tried to reach Brahma, the god of knowledge. This may be how they came to be seen as the steed of Brahma.'),
(?, 6, 2, 'A heroic monkey god of Hindu descent who is renowned and popular. He is extremely nimble and has extraordinary knowledge.
He is known to have helped Vishnu in the guise of Prince Rama and performed many heroic deeds in the Ramayana. His name means "jaw," and he has golden skin, a red face that shines like a ruby, and an extremely long tail. Since he is the son of the wind god Vayu, he can fly and change shape into many forms.'),
(?, 6, 4, 'Son of Vishnu and the wise King of the Bears in Hindu lore. He leads an army of bears.
In the Valmiki Ramayana, he assisted Prince Rama along with Hanuman, the monkey god, and fought against Ravana. In honor of his service, Prince Rama granted him the blessing of being weak only against his father. But in the Mahabharata, he has to fight Krishna, an incarnation of his father Vishnu, over a magic jewel, during which he is slain.'),
(?, 6, 2, 'A king of the birds, appearing in the Indian epic "Ramayana."
He takes the form of a vulture and was said to have lived for over 6,000 years.
Although he is the son of Arna, brother of Garuda, another king of the birds, he is also sometimes considered the son of Garuda himself.
In the "Ramayana," he forms a friendship with King Rama, an incarnation of the supreme Hindu deity Vishnu, and promised to protect his queen, Sita. However, Sita was kidnapped by Ravana, king of the Rakshasas and an enemy of Rama.
He set out alone to save Sita, but had his wings cut off by a sword and was mortally wounded. He died in the arms of Rama.'),
(?, 6, 1, 'A goddess of Indian mythology. She is one of the consorts of Shiva, the god of destruction.
Her name means "black one" and is derived from the word "kala" (black), but has also come to mean "goddess of time." Her sacred place is Calcutta, where she still retains many followers who worship her as a mother goddess. She is identified with Durga, an alternate aspect of Parvati transformed by anger at Asura into a fearsome form.
She loves blood, wine, slaughter, and battle. She is black from head to toe and has four arms, each of which is always carrying a blood-stained weapon or a severed head. However, her arms are said to have the power to grant blessings to those who believe in her.'),
(?, 6, 5, 'The Hindu god of sexual desire. He looks like a young, handsome man on a owl.
He uses honeybees as his string and shoots arrows tipped with flowers. By a request of the gods, he shot Shiva, but Shiva was angered and burned him with his third eye.'),
(?, 6, 5, 'A Hindu god of war, also known as Skanda and Murugan.
He rides upon a peacock called Paravani, with bow and arrow drawn. He commands the army of the gods, and defeated the forces of Asura.'),
(?, 6, 5, 'A divine hero of Hindu mythology. He is the eighth avatar of Vishnu, who is said to appear whenever the world is at risk. Name is sometimes translated as "all-attractive."
Raised by cow herders. As a boy, he would play his flute, causing women to flock to him. As an adult, he became a great tactician. Shot in the back of the leg by mistake by a hunter named Jara.'),
(?, 6, 1, 'The goddess of beauty and good fortune in Hindu lore. She is a love goddess, wife to Vishnu and mother to Kama.
She is the embodiment of the ideal woman and is said to have charmed many gods with her dance.'),
(?, 6, 1, 'A giant Asura in Hinduism whose name means "the intoxication."
It is said that the sage Chyavana created it from fire. He has the power to swallow its enemies, and even the deity Indra has been said to surrender to its power.'),
(?, 6, 4, 'An Indian god who repels evil, known as Daikokuten in Buddhism.
His swords are fearsome, but by paying tribute to him, his worshippers are blessed with tremendous wealth and happiness. One theory holds that he is an incarnation of Shiva, the destroyer.'),
(?, 6, 3, 'A holy creature that carries the gods on its back in Hindu lore. It lives in rivers and lakes.
It is a type of fish said to have the qualities of crocodiles, hippopotami, elephants, and Naga. In the Da Tang Xiyu Ji, a Buddhist record of the western world, it is the size of a mountain and its eyes shine like the sun.'),
(?, 6, 2, 'A sun goddess of Buddhism, her name means "light" or "heat haze." In Japan, where she is known as Marishiten, she was worshipped by warriors, said to protect them from harm and enemy detection. Often portrayed as having three heads and six-to-eight arms, holding weapons such as swords, bows, and vajra.'),
(?, 6, 5, 'The Hindu personification of illusion. It is said to have the power to make humans aware and become enlightened about "phenomena" caused by things on Earth.
One of these of Burmese lore was a mother goddess and may have some relation to the goddess of illusion.'),
(?, 6, 1, 'Snake gods of Indian mythology, depicted as being half-snake and half-human. They are regarded as gods of rebirth or reincarnation. They live at the bottom of lakes, in rivers and oceans. When they are not at war, they live a joyful life singing and dancing.'),
(?, 6, 2, 'The king of the serpent people in Hindu mythology. He is the largest of all those that live in the ocean. The dragon kings Nanda and Takshaka of Buddhist myth fall into this royal category.'),
(?, 6, 4, 'A sacred cow that serves as the mount of the god Shiva in Hindu tradition. Its name means "fortunate one," and it symbolizes fertility and the harvest. Its body is the color of milk and it carries Shiva and his wife Parvati on its back. Shiva is also known as the god of dance, and when he dances, his mount plays the music.
It is enshrined alongside Shiva in many temples in India. Its statue is always set facing the statue of Shiva so that it is ready to serve its master at any moment.'),
(?, 6, 5, 'A half-human, half-lion god in Indian mythology. The fourth avatar of the preserver god Vishnu.
Hiranyakashipu from the Asura was granted the wish for a body that could not be killed by god nor Asura, man or beast, during day or night, inside or outside of a residence, nor by any weapon. For the sake of defeating that Hiranyakashipu, Vishnu took on the form of a lion-headed man.'),
(?, 6, 4, 'A monkey god in Hindu mythology, he is the general of the army of Hanuman. In the Ramakian, the national epic of Thailand, it is written that he fought with a giant and freed it from its curse.'),
(?, 6, 1, 'An extremely beautiful consort of Shiva in Hindu mythology, she symbolizes many virtues. She is the reincarnation of Sati, the previous wife of Shiva.
Always by his side and won his love, overcoming his asceticism. She plunged the world into darkness by closing his two eyes, aiding in the opening of his third eye.'),
(?, 6, 2, 'A type of demon in Hindu mythology that arises from the vices of men such as criminals, drunkards and adulterers.
Known to feast on the flesh of corpses, it is said that it can possess a human by entering through their mouth, where it will plague them until it is driven away through magic or medicine. It is also said that anyone who looks upon one directly is guaranteed to die within nine months. '),
(?, 6, 3, 'In Hindu mythology, he is a god with a head of an elephant and a third eye on his forehead. Although his looks suggests influence from Ganesha, he is thought to have originally been a local god of Tibet.'),
(?, 6, 1, 'Evil spirits that battle the gods in Hindu lore. They also attack humans.
Their hideous appearance symbolizes their evil nature, but they can also change shape to fool humans.'),
(?, 6, 5, 'A prince of Kosala and the seventh avatar of Vishnu. He is the protagonist of the epic poem, the Ramayana. He defeated Ravana the rakshasa, who was unkillable by neither god nor demon.
His serious and earnest personality made him a popular hero in India.'),
(?, 6, 1, 'In Hindu lore, she is the consort of Brahma and the goddess of knowledge, music, and art, who appears with a vina.
Because Vedas, songs offered to the gods, are said to be her creation, she is known as the mother of the Vedas. Brahma was fascinated by her beauty and though she tried to dodge his gaze, each time a new face formed. Finally, after he gained four faces, she realized that she could not escape and gave up, becoming his wife.'),
(?, 6, 3, 'The first consort of Shiva in Hindu mythology, she threw herself into a sacrificial fire in protest of the mistreatment that her father had towards Shiva. Reincarnated as Parvati, she was reunited with Shiva.'),
(?, 6, 1, 'The great god who governs the destruction and creation of the world. He is the most worshiped god in Hinduism alongside Vishnu.
It is said that he purifies the world through destruction only to rebuild it anew, and though he casts terrifying destruction against the demons, he also blesses his followers. He has been depicted in many ways, but the most common is for him to have four hands, one face, and three eyes. He wields a trishula, or trident, and his third eye is said to emit a ray of light that destroys all it touches.'),
(?, 6, 2, 'A legendary bird of Hindu lore. Its name means "one with beautiful wings."
It can create wind at will by flapping its wings and can also change its size freely.'),
(?, 6, 4, 'A female Vetala in Hindu mythology. Some say she was the daughter of the demon Sunda, others say she was the daughter of Sketu, a yaksha.
In the Ramayana, she incurred the wrath of the renowned sage Agastya and was transformed into a Rakshasi (Rajasthani woman). She lived in the forests in the basin of the Ganges River. Rama managed to cut off her arms, and even though she turned invisible, he was able to slay her at the order of the holy hermit Vishvamitra when she was ravaging the surrounding area.'),
(?, 6, 3, 'An Indian deity that serves Yama, the god of death.
When Yama judges a dead soul to be guilty, he acts as the executioner and drags that soul to hell.'),
(?, 6, 1, 'A giant serpent of Hindu lore.
It is said that gods and demons used his body to churn the chaotic sea of milk and create Amrita, or immortality. Using Mt. Mandara as a pole and his body wrapped around it as a rope, the gods and demons took turns pulling his body on either side, moving Mt. Mandara around in the sea. The strain from this caused him to spew incredibly poisonous venom, which was then safely swallowed by Shiva before it could ruin Amrita.'),
(?, 6, 4, 'A type of Preta appearing in Hindu tradition. They are the most dangerous of all Preta. They possess the dead bodies of humans and are constantly plotting their return to the realm of the living. Their eyes glow with a dull light.
Legends say that they wield secret arts and can raise the dead by chanting mantras.
They are considered the greatest of all evil spirits, and also a form of vampire. They suck the blood of their victims and bend them to their will, even controlling their movements like puppets.
In Buddhist tradition, they are called Kondara or Metara.'),
(?, 6, 1, 'One of the supreme deities in Indian mythology. He presides over maintenance and prosperity. His role is the preserver of the universe. It is believed that he will descend to earth ten times to maintain the balance of power. He is often depicted with four arms, a chakram called "Sudarsana," a club called "Kaumodakhi," a conch called "Panchajana," and a lotus flower.'),
(?, 6, 5, 'A gigantic serpentine monster or giant that appears in the Rig Veda and other books. Its name means "obstacle" or "one who covers heaven and earth (the universe). Kasyapa, a holy sage who was plotting revenge against God, performed a ritual to bestow a creature comparable to God, and was born from a flame. He hates all living creatures and God from birth. With his huge body, he blocked the water flowing from the heavens, covered the sun with darkness, starved the earth, and caused a drought by capturing the "cloud cow" that called for rain. In several scriptures, he is depicted as a rival to Indra. When fighting Indra, he transforms into a giant serpent. Indra was once swallowed by him, but escaped while the serpent was yawning. Through the mediation of Vishnu, he made peace with Indra on the condition that "no god can attack me day or night, by wood, stone, iron, dry or wet. "Indra" killed "him" by attacking his weak point, his mouth, at dusk, neither day nor night, with "Vajra," a weapon made from the "bone" of the holy nymph "Dadicha," which was outside the condition. The water that had been blocked at that time flowed, and the return of the "cloud cow" brought heavy rains. Since this serpent returns every year, it is said that the battle against Indra continues to be fought every year.'),
(?, 6, 3, 'A spirit of demigod status that serves the Hindu god of wealth. It lives in the Himalayas and guards treasure.
It is a holy spirit of sorts that lives in other worlds, in the air, in forests, and underwater. It is known as Yasha in Buddhism, and protects its teachings. It prevents invasion of homes by evil spirits, grants blessings to the good, and devours the evil. It is a benevolent god in India, but in Japan, it is known as a dreadful man-eating demon that kills men and devours their bodies and souls.'),
(?, 6, 2, 'Semi-divine beings in Hindu mythology.
Though they were once worshiped by the Dravidians as goddesses of the harvest, they became interpreted as demons with the spread of Hinduism and the two clashing ideologies. They are depicted as naked women with voluptuous bodies.'),
(?, 6, 2, 'In Hindu lore, he is a god who manages hell. He has been incorporated into Buddhism as well, where he is well-known as King Enma.
He was originally born human and had a twin sister named Yami. He died first, which filled Yami with sorrow. The gods created day and night for her to forget him. As the first person to die, he was given the role of guiding the deceased to the land of the dead, but he eventually began punishing them according to their deeds while alive. Originally, the land of the dead consisted only of heaven, but through his work, hell was born and over time he came to manage it.');

INSERT INTO Answer (aId, qId, aText) VALUES
--Abrahamic
(?, 1, 'Angel'),
(?, 2, 'Archangel'),
(?, 3, 'Principality'),
(?, 4, 'Power'),
(?, 5, 'Virtue'),
(?, 6, 'Dominion'),
(?, 7, 'Throne'),
(?, 8, 'Cherub'),
(?, 9, 'Seraph'),
(?, 10, 'Gabriel'),
(?, 11, 'Raphael'),
(?, 12, 'Uriel'),
(?, 13, 'Michael'),
(?, 14, 'Abaddon'),
(?, 15, 'Lucifer'),
(?, 16, 'Satan'),
(?, 17, 'Beelzebub'),
(?, 18, 'Metatron'),
(?, 19, 'Sandalphon'),
(?, 20, 'White Rider'),
(?, 21, 'Red Rider'),
(?, 22, 'Black Rider'),
(?, 23, 'Pale Rider'),
(?, 24, 'Trumpeter'),
(?, 25, 'Mother Harlot'),
(?, 26, 'Moloch'),
(?, 27, 'Mot'),
(?, 28, 'Samael'),
(?, 29, 'Lailah'),
(?, 30, 'Lilith'),
(?, 31, 'Lilim'),
(?, 32, 'Mastema'),
--Norse
(?, 33, 'Dis'),
(?, 34, 'Dwarf'),
(?, 35, 'Elf'),
(?, 36, 'Fafnir'),
(?, 37, 'Fenrir'),
(?, 38, 'Heimdall'),
(?, 39, 'Hel'),
(?, 40, 'Hresvelgr'),
(?, 41, 'Loki'),
(?, 42, 'Baldur'),
(?, 43, 'Nidhoggr'),
(?, 44, 'Norn'),
(?, 45, 'Odin'),
(?, 46, 'Skadi'),
(?, 47, 'Sleipnir'),
(?, 48, 'Surt'),
(?, 49, 'Thor'),
(?, 50, 'Troll'),
(?, 51, 'Valkyrie'),
(?, 52, 'Vidofnir'),
(?, 53, 'Yggdrasil'),
(?, 54, 'Idun'),
(?, 55, 'Siegfried'),
--Goetia
(?, 56, 'Agares'),
(?, 57, 'Amon'),
(?, 58, 'Andras'),
(?, 59, 'Asmodeus'),
(?, 60, 'Astaroth'),
(?, 61, 'Bael'),
(?, 62, 'Barbatos'),
(?, 63, 'Belial'),
(?, 64, 'Berith'),
(?, 65, 'Bifrons'),
(?, 66, 'Botis'),
(?, 67, 'Dantalian'),
(?, 68, 'Decarabia'),
(?, 69, 'Eligor'),
(?, 70, 'Flauros'),
(?, 71, 'Forneus'),
(?, 72, 'Gemori'),
(?, 73, 'Glasya-Labolas'),
(?, 74, 'Halphas'),
(?, 75, 'Morax'),
(?, 76, 'Murmur'),
(?, 77, 'Orias'),
(?, 78, 'Orobas'),
(?, 79, 'Ose'),
(?, 80, 'Paimon'),
(?, 81, 'Seere'),
(?, 82, 'Shax'),
(?, 83, 'Stolas'),
--Japanese
(?, 84, 'Amabie'),
(?, 85, 'Amanojaku'),
(?, 86, 'Amaterasu'),
(?, 87, 'Ame-no-Uzume'),
(?, 88, 'Arahabaki'),
(?, 89, 'Chironnupu'),
(?, 90, 'Futsunushi'),
(?, 91, 'Fuu-Ki'),
(?, 92, 'Gashadokuro'),
(?, 93, 'Gozu-Tennoh'),
(?, 94, 'Hare of Inaba'),
(?, 95, 'Hinokagutsuchi'),
(?, 96, 'Hachiman'),
(?, 97, 'Hitokotonushi'),
(?, 98, 'Ichimokuren'),
(?, 99, 'Inugami'),
(?, 100, 'Ippon-Datara'),
(?, 101, 'Izanagi'),
(?, 102, 'Izanami'),
(?, 103, 'Kaguya'),
(?, 104, 'Kin-Ki'),
(?, 105, 'Kushinada'),
(?, 106, 'Makami'),
(?, 107, 'Masakado'),
(?, 108, 'Mishaguji'),
(?, 109, 'Nekomata'),
(?, 110, 'Ongyo-Ki'),
(?, 111, 'Oni'),
(?, 112, 'Sui-Ki'),
(?, 113, 'Susano-o'),
(?, 114, 'Turbo Granny'),
(?, 115, 'Tsukiyomi'),
(?, 116, 'Yamato-no-Orochi'),
(?, 117, 'Yatagarasu'),
(?, 118, 'Yatsufusa'),
(?, 119, 'Yoshitsune'),
--Greco-Roman
(?, 120, 'Artemis'),
(?, 121, 'Atlas'),
(?, 122, 'Atropos'),
(?, 123, 'Attis'),
(?, 124, 'Caesar'),
(?, 125, 'Caladrius'),
(?, 126, 'Catoblepas'),
(?, 127, 'Centaur'),
(?, 128, 'Cerberus'),
(?, 129, 'Charon'),
(?, 130, 'Chimera'),
(?, 131, 'Chronos'),
(?, 132, 'Clotho'),
(?, 133, 'Cybele'),
(?, 134, 'Daphne'),
(?, 135, 'Diana'),
(?, 136, 'Demeter'),
(?, 137, 'Dionysus'),
(?, 138, 'Echidna'),
(?, 139, 'Fortuna'),
(?, 140, 'Harpy'),
(?, 141, 'Hecate'),
(?, 142, 'Hecatoncheires'),
(?, 143, 'Hermes'),
(?, 144, 'Hydra'),
(?, 145, 'Hypnos'),
(?, 146, 'Io'),
(?, 147, 'Lachesis'),
(?, 148, 'Medusa'),
(?, 149, 'Mercurius'),
(?, 150, 'Minotaur'),
(?, 151, 'Mithras'),
(?, 152, 'Narcissus'),
(?, 153, 'Nike'),
(?, 154, 'Nyx'),
(?, 155, 'Orpheus'),
(?, 156, 'Orthrus'),
(?, 157, 'Ouroboros'),
(?, 158, 'Pales'),
(?, 159, 'Persephone'),
(?, 160, 'Prometheus'),
(?, 161, 'Python'),
(?, 162, 'Saturnus'),
(?, 163, 'Thanatos'),
(?, 164, 'Zeus'),
--Hinduism
(?, 165, 'Agni'),
(?, 166, 'Airavata'),
(?, 167, 'Ananta'),
(?, 168, 'Apsaras'),
(?, 169, 'Ardha'),
(?, 170, 'Asura'),
(?, 171, 'Churel'),
(?, 172, 'Enku'),
(?, 173, 'Ganesha'),
(?, 174, 'Ganga'),
(?, 175, 'Gurr'),
(?, 176, 'Hamsa'),
(?, 177, 'Hanuman'),
(?, 178, 'Jambavan'),
(?, 179, 'Jatayu'),
(?, 180, 'Kali'),
(?, 181, 'Kama'),
(?, 182, 'Kartikeya'),
(?, 183, 'Krishna'),
(?, 184, 'Lakshmi'),
(?, 185, 'Mada'),
(?, 186, 'Mahakala'),
(?, 187, 'Makara'),
(?, 188, 'Marici'),
(?, 189, 'Maya'),
(?, 190, 'Naga'),
(?, 191, 'Naga Raja'),
(?, 192, 'Nandi'),
(?, 193, 'Narasimha'),
(?, 194, 'Onkot'),
(?, 195, 'Parvati'),
(?, 196, 'Pisaca'),
(?, 197, 'Pulukishi'),
(?, 198, 'Rakshasa'),
(?, 199, 'Rama'),
(?, 200, 'Sarasvati'),
(?, 201, 'Sati'),
(?, 202, 'Shiva'),
(?, 203, 'Suparna'),
(?, 204, 'Taraka'),
(?, 205, 'Turdak'),
(?, 206, 'Vasuki'),
(?, 207, 'Vetala'),
(?, 208, 'Vishnu'),
(?, 209, 'Vritra'),
(?, 210, 'Yaksa'),
(?, 211, 'Yaksini'),
(?, 212, 'Yama');

INSERT INTO Icon (iconId, iconName) VALUES
(?, 'Arcana-Back'),
(?, 'Chariot'),
(?, 'Death'),
(?, 'Devil'),
(?, 'Emperor'),
(?, 'Empress'),
(?, 'Fool'),
(?, 'Fortune'),
(?, 'Hanged-Man'),
(?, 'Hermit'),
(?, 'Hierophant'),
(?, 'Hunger'),
(?, 'Jester'),
(?, 'Judgement'),
(?, 'Justice'),
(?, 'Lovers'),
(?, 'Magician'),
(?, 'Moon'),
(?, 'P5-Arcana-Back'),
(?, 'P5-Chariot'),
(?, 'P5-Consultant'),
(?, 'P5-Death'),
(?, 'P5-Devil'),
(?, 'P5-Emperor'),
(?, 'P5-Empress'),
(?, 'P5-Faith'),
(?, 'P5-False-Faith'),
(?, 'P5-Fool'),
(?, 'P5-Fortune'),
(?, 'P5-Hanged-Man'),
(?, 'P5-Hermit'),
(?, 'P5-Hierophant'),
(?, 'P5-Judgement'),
(?, 'P5-Justice'),
(?, 'P5-Lovers'),
(?, 'P5-Magician'),
(?, 'P5-Moon'),
(?, 'P5-Priestess'),
(?, 'P5-Star'),
(?, 'P5-Strength'),
(?, 'P5-Sun'),
(?, 'P5-Temperance'),
(?, 'P5-Tower'),
(?, 'P5-World'),
(?, 'Priestess'),
(?, 'Star'),
(?, 'Strength'),
(?, 'Sun'),
(?, 'Temperance'),
(?, 'Tower'),
(?, 'World');