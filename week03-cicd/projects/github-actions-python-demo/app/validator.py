"""Simple configuration validation functions."""


def validate_environment(environment: str) -> bool:
    """Return True when the environment is supported."""
    allowed_environments = {"development", "staging", "production"}
    return environment.lower() in allowed_environments