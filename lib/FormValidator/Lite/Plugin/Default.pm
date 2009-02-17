package FormValidator::Lite::Plugin::Default;
use FormValidator::Lite::Plugin;

rule 'NULL' => sub { !$_ || $_ eq ""       };
rule 'INT'  => sub { $_ =~ /^[+\-]?[0-9]+$/ };
rule 'UINT' => sub { $_ =~ /^[0-9]+$/      };
alias 'NULL' => 'BLANK';

rule 'ASCII' => sub {
    $_ =~ /^[\x21-\x7E]+$/
};

# {mails => [qw/mail1 mail2/]} => ['DUPLICATION']
rule 'DUPLICATION' => sub {
    $_->[0] eq $_->[1]
};

# 'name' => [qw/LENGTH 5 20/],
rule 'LENGTH' => sub {
    my $length = length($_);
    my $min    = shift;
    my $max    = shift || $min;
    Carp::croak("missing \$min") unless defined($min);

    ( $min <= $length and $length <= $max )
};

rule 'REGEX' => sub {
    my $regex = shift;
    Carp::croak("missing args at REGEX rule") unless defined $regex;
    $_ =~ /$regex/
};
alias 'REGEX' => 'REGEXP';

1;