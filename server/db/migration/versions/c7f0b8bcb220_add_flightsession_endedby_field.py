"""add flightsession endedby field

Revision ID: c7f0b8bcb220
Revises: faf105487df8
Create Date: 2025-02-28 15:33:37.683123

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'c7f0b8bcb220'
down_revision: Union[str, None] = 'faf105487df8'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column("flightsessions",sa.Column("endedby", sa.String, nullable=True)) 


def downgrade() -> None:
    op.drop_column("flightsessions","endedby")
