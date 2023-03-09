#include <iostream>
#include <fstream>
#include <string>
#include <optional>

// ? Is open
// ? prepared_tests
// ? file exists

struct CommandLineArgs
{
    std::ifstream fin;
    std::ofstream fout;
    std::string stringToReplace;
    std::string stringToReplaceWith;
};

std::optional<CommandLineArgs> ParseCommandLine(int argn, char** argv)
{
    if (argn != 5)
    {
        std::cout << "Invalid argument count\n"
            << "Usage: replace.exe <inputFile> <outputFile> <searchString> <replacementString>\n";
        return std::nullopt;
    }

    CommandLineArgs args = {
        std::ifstream(argv[1]),
        std::ofstream(argv[2]),
        argv[3],
        argv[4],
    };

    if (!args.fin.is_open())
    {
        std::cout << "Could not open " << argv[1] << "\n";
        return std::nullopt;
    }

    if (!args.fout.is_open())
    {
        std::cout << "Could not open " << argv[2] << "\n";
        return std::nullopt;
    }

    return args;
}

std::string ReplaceString(
    const std::string& line,
    const std::string& stringToReplace,
    const std::string& stringToReplaceWith
)
{
    if (stringToReplace.empty())
    {
        return line;
    }

    size_t currentPosition = 0;
    std::string result;

    while (currentPosition < line.length())
    {
        size_t stringToReplaceStartPosition = line.find(stringToReplace, currentPosition);

        if (stringToReplaceStartPosition != std::string::npos)
        {
            result.append(line, currentPosition, stringToReplaceStartPosition - currentPosition).append(stringToReplaceWith);

            currentPosition = stringToReplaceStartPosition + stringToReplace.length();
        }
        else {
            result.append(line, currentPosition);

            currentPosition = line.length();
        }
    }

    return result;
}

void WriteNewContentToFile(
    std::ifstream& fin,
    std::ofstream& fout,
    const std::string& stringToReplace,
    const std::string& stringToReplaceWith
)
{
    std::string line;

    while (getline(fin, line))
    {
        fout << ReplaceString(line, stringToReplace, stringToReplaceWith) << "\n";
    }
}

int main(int argn, char** argv)
{
    std::optional<CommandLineArgs> args = ParseCommandLine(argn, argv);

    if (!args)
    {
        return 1;
    }

    WriteNewContentToFile(
        args->fin,
        args->fout,
        args->stringToReplace,
        args->stringToReplaceWith
    );

    if (!args->fout.flush())
    {
        std::cout << "File wasn't close\n";
    }

    return 0;
}