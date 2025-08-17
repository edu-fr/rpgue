# Coding Standards and Tooling Setup

This project follows strict coding conventions to maintain consistency and readability. This document outlines the
standards and how to set up your development environment.

## Coding Conventions

### Naming

- **Functions**: `snake_case()` for public, `_snake_case()` for private
- **Variables**: `camelCase` for public, `_camelCase` for private
- **Constants/Enums**: `UPPER_SNAKE_CASE`
- **Classes**: `PascalCase`
- **Nodes**: `PascalCase`

### Formatting

- Use tabs for indentation (4 spaces wide)
- All code and comments in English
- Functions should be descriptive and self-documenting

## Development Setup

### Editor Configuration

1. **Godot Editor**:
	- Enable "Auto Format on Save" in Editor Settings
	- Use the provided `code_style.cfg` for consistent formatting

2. **Rider/IntelliJ**:
	- Import the code style from `.idea/codeStyles/Project.xml`
	- Enable "Reformat on Save"
	- Install the GDScript plugin if not already installed

3. **VSCode**:
	- Install the GDScript extension
	- Add the following to your settings.json:
   ```json
   {
       "editor.tabSize": 4,
       "editor.insertSpaces": false,
       "editor.detectIndentation": false,
       "files.trimTrailingWhitespace": true,
       "files.insertFinalNewline": true,
       "files.trimFinalNewlines": true
   }
   ```

### Git Hooks

A pre-commit hook is set up to automatically format GDScript files before each commit. To enable it:

1. Make the pre-commit hook executable (Linux/Mac):
   ```bash
   chmod +x .git/hooks/pre-commit
   ```

2. On Windows, the hook will work as is.

## Linting and Formatting

### Manual Formatting

To manually format all GDScript files:

```bash
godot --headless --no-window --script res://addons/gdscript/format/format_script.gd -a "res://"
```

### Linting

For additional linting, consider using `gdscript-lsp` with your editor's LSP integration.

## Best Practices

1. **Documentation**:
	- Use docstrings for all public functions and classes
	- Document complex logic with comments
	- Keep comments up-to-date with code changes

2. **Version Control**:
	- Write clear, concise commit messages
	- Make atomic commits
	- Reference issues in commit messages when applicable

3. **Code Organization**:
	- Group related functionality in the same directory
	- Keep files focused and of reasonable size
	- Use signals for decoupled communication
