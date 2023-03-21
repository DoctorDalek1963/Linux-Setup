#![feature(iter_intersperse)]

use clap::Parser;
use color_eyre::Result;
use levenshtein::levenshtein;
use rayon::prelude::*;
use std::fs;

/// A simple struct to hold the parsed arguments.
#[derive(Clone, Debug, Parser)]
#[command(author, version, about)]
struct Args {
    /// The path of the history file to clean.
    filename: String,

    /// The number of most recent lines to keep regardless.
    #[arg(short, long, default_value_t = 100)]
    keep_lines: usize,

    /// The minimum score to use for keeping lines.
    ///
    /// A line needs to be _at least this different_ for it to be kept.
    ///
    /// A score of 0 means the lines are identical; 1 means they're the same length with no letters
    /// in common; more than 1 means they are very dissimilar.
    #[arg(short, long, default_value_t = 0.2)]
    threshold: f32,

    /// We assume that the most recent commands are at the end of the file by default; this flag
    /// will flip that to assume the most recent commands are at the start.
    #[arg(short, long)]
    reverse: bool,
}

/// Calculate the difference score between two strings.
///
/// This is the Levenshtein distance, divided by the average length of the strings to normalise it.
///
/// A score of 0 means the strings are identical; 1 means they're the same length with no letters
/// in common; more than 1 means they are very dissimilar.
fn score(a: &str, b: &str) -> f32 {
    levenshtein(a, b) as f32 / ((a.len() + b.len()) as f32 / 2.)
}

/// Filter the lines using the given threshold, keeping the specified number of lines.
///
/// This function does _not_ handle reversing the lines.
///
/// See [`score.`]
fn filter_lines(lines: Vec<&str>, keep_lines: usize, threshold: f32) -> Vec<&str> {
    let mut kept_lines: Vec<&str> = lines.iter().take(keep_lines).map(|&s| s).collect();

    for line in lines.into_iter().skip(keep_lines) {
        if kept_lines
            .par_iter()
            .map(|&s| score(s, line))
            .reduce(|| threshold + 1., f32::min)
            > threshold
        {
            kept_lines.push(line);
        }
    }

    kept_lines
}

/// Filter a whole file. See [`filter_lines`].
fn filter_whole_file(args: &Args, content: String) -> String {
    let lines: Vec<&str> = if !args.reverse {
        content.lines().rev().collect()
    } else {
        content.lines().collect()
    };

    let lines = filter_lines(lines, args.keep_lines, args.threshold)
        .into_iter()
        .intersperse("\n");
    if !args.reverse {
        lines.collect::<Vec<_>>().into_iter().rev().collect()
    } else {
        lines.collect()
    }
}

/// Read the file, filter the file, write the file back.
fn main() -> Result<()> {
    let args = Args::parse();

    let path = fs::canonicalize(&args.filename)?;
    let content = fs::read_to_string(&path)?;
    let new = filter_whole_file(&args, content);

    fs::write(path, new)?;

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn score_test() {
        assert_eq!(score("hello world", "hello world"), 0.);
        assert_eq!(score("ABBA", "Dido"), 1.);
        assert_eq!(
            score("gst", "gs -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress"),
            1.7446809
        );
    }
}
