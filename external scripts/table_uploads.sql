## adding our tables to Team3 database

## bin table

create table Bin (
	binID INT not null,
	chrom varchar(10) not null,
	start INT not null,
	end INT not null,
	primary key(binID)
) ENGINE = InnoDB;

load data local infile 'bin1.csv' into table Bin
fields terminated by ','
(binID, chrom, start, end);

## gene table

create table Gene (
	gID INT not null,
	name varchar(50),
	chrom varchar(10) not null,
	start INT not null,
	end INT not null,
	primary key(gid)
) ENGINE = InnoDB;

load data local infile 'gene_table_filtered1.csv' into table Gene
fields terminated by ','
(gid, name, chrom, start, end);

## since gene name can now be null,
## update gene name to be "NA" or "NULL" when empty
update Gene
set name = 'NA'
where name is null;

## map table

create table Map (
	binID INT not null,
	gID INT not null,
	primary key(gID, binID),
	foreign key(binID) references Bin(binID),
	foreign key(gID) references Gene(gID)
) ENGINE = InnoDB;

insert into Map(binID, gID)
select b.binID, g.gID
from Bin b join Gene g on b.chrom = g.chrom
where b.binID not in (select b.binID from Bin b join Gene g on b.chrom = g.chrom where (b.end <= g.start or b.start >= g.end));

## experiment table

create table Experiment (
	expID INT not null,
	genotype varchar(50) not null,
	cell_type varchar(50),
	stage INT,
	bin_size INT,
	normalization varchar(50),
	primary key(expID)
) ENGINE = InnoDB;

load data local infile 'experiment.csv' into table Experiment
fields terminated by ','
(expID, genotype, cell_type, stage, bin_size, normalization)

## interaction table

create table Interaction (
	bin1 INT not null,
	bin2 INT not null,
	primary key(bin1, bin2),
	foreign key bin1 references Bin(binID),
	foreign key bin2 references Bin(binID)
) ENGINE = InnoDB;




show tables;

select * from Gene;




